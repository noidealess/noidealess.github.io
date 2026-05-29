---
name: new-post
description: Create and publish a new article on the Noidealess Hexo photography blog. Use when the user provides article text/content plus photos and wants a new blog post created and put online. Handles a lowercase-kebab post file + its asset folder, copying & numbering the photos into the post and inserting bare-relative image references, choosing tags/categories and a Simplified-Chinese description, lossless image optimization, a verification build, and uploading (commit+push to the `hexo` branch and `hexo deploy` to `main` / GitHub Pages). Trigger on requests like "new post", "new article", "publish this article with these photos", "发新文章", "写一篇博客", "add a blog post and upload".
---

# new-post — author & publish a Noidealess blog post

End-to-end workflow for turning user-provided article content + photos into a live post on the Noidealess Hexo blog (Fluid theme), then uploading it.

Run all commands from the **repository root** (the folder containing `_config.yml`). Every project-specific gotcha is captured under **Invariants** below — read them before publishing.

## Setup (one-time per machine)
Anyone can use this skill after cloning the repo:
1. `npm install` from the repo root (installs Hexo + plugins).
2. `gh auth login` as a GitHub account with **write access** to `noidealess/noidealess.github.io` (HTTPS). The scripts push/deploy via the `gh` credential helper — no SSH key needed.
3. Open Claude Code in the repo; it auto-discovers this skill from `.claude/skills/new-post/`.

## When to use
The user hands you article text (usually Simplified Chinese) and one or more photos/screenshots and wants them published as a new blog post. Also use for "draft a post but don't upload yet" — just stop before the Publish step.

## Inputs to collect (ask only for what's missing)
1. **Title** — the real (often Chinese) post title → goes in front-matter `title:`.
2. **Slug** — a short **ASCII lowercase-kebab-case** name → becomes the filename and URL (e.g. `fast-lens`, `pixel-shift`). If the title is Chinese, propose a slug (pinyin or English) and confirm. Never use uppercase or spaces — this filesystem is case-insensitive and case-only renames are painful (see Invariants).
3. **Body** — the article markdown/text.
4. **Photos** — file paths (or a folder) the user gives you, plus where each image goes in the article (numbered list, inline markers, or "in order"). If placement is unclear, ask.
5. **Tags / categories** — infer from content and confirm, reusing existing taxonomy (below).
6. **Author** — optional pen-name (existing posts use `Δ` or `Σ`). Don't invent one; ask or omit.
7. **Banner** — optional; if the user wants a header image, save it to `source/banner/<slug>.<ext>` and set `banner_img: /banner/<slug>.<ext>`.

## Procedure

### 1. Scaffold the post
```bash
./node_modules/.bin/hexo new post "<TITLE>" -s <slug>
```
`post_asset_folder: true`, so this creates **both** `source/_posts/<slug>.md` and the asset folder `source/_posts/<slug>/`. Verify the created file is exactly `<slug>.md`, lowercase ASCII. If it came out wrong, delete and recreate with the right `-s` slug (do **not** fix with a case-only rename).

### 2. Place & index the photos
Copy each photo into `source/_posts/<slug>/`, numbered in reading order, with the extension matching the **real** type (detect with `file --mime-type`, not the original extension — some `.jpg` files are actually PNG):
```bash
file --mime-type <photo>        # image/jpeg -> .jpg, image/png -> .png
cp <photo> source/_posts/<slug>/1.jpg   # 1.jpg, 2.png, 3.jpg, ...
```
Then insert **bare-relative** references into the body at the right spots — never folder-prefixed:
```markdown
![](1.jpg)
```
(Correct: `![](1.jpg)`. Wrong: `![](<slug>/1.jpg)` or absolute paths.)

### 3. Write front-matter (project convention)
```yaml
---
title: <real title, may be Chinese>
date: <keep the date hexo generated>
tags: [标签1, 标签2]
categories: [分类]
description: <one concise, accurate Simplified-Chinese sentence summarizing the post, ~15-45 chars; no fabricated facts>
banner_img: /banner/<slug>.<ext>   # only if a banner was provided
author: Δ                          # only if the user gave one
---
```
Rules: keys are `tags:`/`categories:` (never `tag:`/`category:`), inline arrays with **one space after each comma**. Don't invent author or banner. Keep the body text as the user wrote it (only add the image references).

### 4. Tag & categorize
Reuse the existing taxonomy for consistency; add a new term only if nothing fits.
- **categories** seen: `教程`, `科普`, `照片分享`, `理论推导`, `光学设计`, `公告`
- **tags** seen: `风光`, `虚化`, `高分辨率`, `像素漂移`, `落叶`, `中大`, `Zemax`, `科普`, `教程`, `公告`

### 5. Optimize images (lossless)
```bash
bash .claude/skills/new-post/scripts/optimize-images.sh source/_posts/<slug>
# also optimize the banner if you added one:
# bash .claude/skills/new-post/scripts/optimize-images.sh source/banner
```
This re-encodes JPEGs (jpegtran, EXIF preserved) and PNGs (optipng) in place, routing by real MIME type, keeping a result only if smaller. It auto-`npm rebuild`s the imagemin binaries if they're missing (see Invariants).

### 6. Verify build (before uploading)
```bash
./node_modules/.bin/hexo clean && ./node_modules/.bin/hexo generate
ls public/*/*/*/<slug>/index.html      # the post page exists
test -f public/CNAME && cat public/CNAME   # MUST print noidealess.org
```
Confirm: the post page generated, its images copied alongside it, the slug is lowercase, and `public/CNAME` is present. Fix any error before continuing.

### 7. Publish (PRODUCTION — confirm first)
Uploading pushes the source to the `hexo` branch and force-deploys the generated site to `main` (GitHub Pages). **Ask the user to confirm they want it live**, then:
```bash
bash .claude/skills/new-post/scripts/publish.sh "v$(date +%Y.%-m.%-d) add <slug>"
```
This sets the commit identity, rebuilds imagemin bins if needed, builds, **guards that `public/CNAME` exists** (never deploy without it — a missing CNAME unsets the custom domain), commits + pushes `hexo` over HTTPS, then `hexo deploy`s to `main` with the git identity passed via env. Afterward, verify:
```bash
gh api repos/noidealess/noidealess.github.io/pages --jq '{cname,status}'   # expect cname=noidealess.org
```

## Invariants (project-specific gotchas — do not relearn the hard way)
- **CNAME**: `source/CNAME` = `noidealess.org` must exist and end up in `public/`. If it's ever missing, GitHub unsets the custom domain and both `noidealess.org` and `noidealess.github.io` break. The publish script aborts if `public/CNAME` is absent.
- **Case-insensitive FS** (`/mnt/c`, `core.ignorecase=true`): always pick the lowercase ASCII slug up front. Avoid case-only renames; if one is unavoidable, rename via a distinct temp name + `git mv -f`, and `git rm --cached` the old casing. After any rename, **delete `.deploy_git`** before deploying so the stale-cased tree doesn't carry over.
- **imagemin binaries**: `node_modules` was populated on Windows, so `jpegtran-bin/optipng-bin/gifsicle/mozjpeg/pngquant-bin` ship broken `vendor/` binaries that crash `hexo generate`. Run `npm rebuild jpegtran-bin optipng-bin gifsicle mozjpeg pngquant-bin` to fetch Linux ELF builds (the scripts do this automatically).
- **Auth & identity**: push over HTTPS `https://github.com/noidealess/noidealess.github.io.git` (the `gh` login `p1nbored` has write access; the `origin` SSH alias doesn't resolve in WSL). Commit identity `noidealess <guotj3@mail2.sysu.edu.cn>` (global git identity is unset). `hexo deploy` needs the identity via `GIT_AUTHOR_*`/`GIT_COMMITTER_*` env vars or it fails with "empty ident name".

## Files in this skill
- `scripts/optimize-images.sh <dir>` — lossless, in-place image optimization for a folder.
- `scripts/publish.sh "<commit message>"` — build + CNAME guard + push `hexo` + deploy `main`.

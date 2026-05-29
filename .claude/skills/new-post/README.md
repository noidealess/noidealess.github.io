# new-post — Claude Code skill

A [Claude Code Agent Skill](https://docs.claude.com/en/docs/claude-code/skills) for the Noidealess Hexo blog. Hand Claude Code an article plus photos and it will create the post, index & losslessly optimize the images, tag & categorize, build, and publish to GitHub Pages.

## Use it
Open Claude Code in this repository and say, for example:
> new post: here's the article and these photos …

Claude reads `SKILL.md` and walks the workflow (it stops before going live and asks you to confirm the upload). See `SKILL.md` for the full procedure and the project-specific invariants.

## Prerequisites (one-time per machine)
- `npm install` from the repo root — installs Hexo and its plugins.
- `gh auth login` as a GitHub user with **write access** to `noidealess/noidealess.github.io`. Push and `hexo deploy` go over HTTPS via the `gh` credential helper, so no SSH key is required.

## Scripts (also runnable by hand)
- `scripts/optimize-images.sh <dir>` — lossless, in-place image optimization (jpegtran/optipng, routed by real MIME type; auto-`npm rebuild`s the imagemin binaries if missing).
- `scripts/publish.sh "<commit message>"` — build, **CNAME guard**, commit + push the `hexo` branch, then `hexo deploy` the site to `main`.

Both scripts must be run from the repository root.

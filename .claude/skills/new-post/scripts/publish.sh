#!/usr/bin/env bash
# Build, push source, and deploy the Noidealess Hexo blog.
# Usage:  bash .claude/skills/new-post/scripts/publish.sh "<commit message>"
# PRODUCTION: pushes to the `hexo` branch and force-deploys the site to `main`
# (GitHub Pages). Run only AFTER the user confirms they want it live.
set -euo pipefail

REPO_HTTPS="https://github.com/noidealess/noidealess.github.io.git"
AUTHOR_NAME="noidealess"
AUTHOR_EMAIL="guotj3@mail2.sysu.edu.cn"
COMMIT_MSG="${1:-Update site}"

# 0. Commit identity: respect an already-configured identity; fall back to the blog's.
git config user.name  >/dev/null 2>&1 || git config user.name  "$AUTHOR_NAME"
git config user.email >/dev/null 2>&1 || git config user.email "$AUTHOR_EMAIL"
NAME="$(git config user.name)"; EMAIL="$(git config user.email)"

# 1. Ensure imagemin binaries exist (node_modules was populated on Windows).
for b in jpegtran-bin/vendor/jpegtran optipng-bin/vendor/optipng \
         gifsicle/vendor/gifsicle mozjpeg/vendor/cjpeg pngquant-bin/vendor/pngquant; do
  if [ ! -x "node_modules/$b" ]; then
    echo "[publish] rebuilding imagemin binaries..."
    npm rebuild jpegtran-bin optipng-bin gifsicle mozjpeg pngquant-bin
    break
  fi
done

# 2. Build.
./node_modules/.bin/hexo clean
./node_modules/.bin/hexo generate

# 3. CNAME guard — never deploy without the custom-domain file, or GitHub unsets it.
if [ ! -f public/CNAME ]; then
  echo "[publish] ERROR: public/CNAME missing — deploying would unset the custom domain (noidealess.org)." >&2
  echo "[publish] Create source/CNAME containing 'noidealess.org' and re-run. Aborting." >&2
  exit 1
fi
echo "[publish] public/CNAME = $(cat public/CNAME)"

# 4. Commit + push the source branch (hexo) over HTTPS (gh credential helper).
git add -A
if git diff --cached --quiet; then
  echo "[publish] no source changes to commit"
else
  git commit -m "$COMMIT_MSG"
fi
git push "$REPO_HTTPS" HEAD:hexo

# 5. Deploy generated site to main. Identity via env so the .deploy_git commit succeeds.
GIT_AUTHOR_NAME="$NAME"     GIT_AUTHOR_EMAIL="$EMAIL" \
GIT_COMMITTER_NAME="$NAME"  GIT_COMMITTER_EMAIL="$EMAIL" \
./node_modules/.bin/hexo deploy

echo "[publish] done. Verify the custom domain is still bound:"
echo "  gh api repos/noidealess/noidealess.github.io/pages --jq '{cname,status}'   # expect cname=noidealess.org"

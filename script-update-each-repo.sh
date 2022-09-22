#!/bin/sh

for f in *; do
  if [ -d "$f" ]; then
    echo $f
    cd $f
    mkdir -p .github
    cp ../sample/dependabot.yml .github/

    git add .github/dependabot.yml
    git commit -m "dependabot.yml"
    git push
    cd ..
  fi
done

#!/bin/sh

cp ../sample/.pre-commit-config.yaml .
cp ../sample/.eslintrc.js .
cp ../sample/.eslintignore .
cp ../sample/prettierignore .
cp ../sample/.gitignore .

mkdir -p .github
cp ../sample/dependabot.yml .github/

git init
yarn init
yarn add -D prettier eslint-plugin-prettier eslint-config-prettier eslint @babel/core @babel/eslint-parser husky lint-staged dotenv

#pre-commit install
husky install
npx husky add .husky/pre-commit "yarn pre-commit"

cat package.json | jq '. + {"lint-staged": {"**/*.{js,jsx,ts,tsx}": ["npx prettier --write", "npx eslint --fix"]}}' > new-package.json
mv new-package.json package.json

cat package.json | jq '. + {"scripts": {"pre-commit": "yarn lint-staged"}}' > new-package.json
mv new-package.json package.json

mkdir src

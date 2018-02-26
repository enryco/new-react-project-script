#!/bin/bash
clear
THIS_PATH=$(dirname ${BASH_ARGV[0]})
GREEN="\033[0;32m"
NC='\033[0m' # No Color

echo -e "Please enter the project name:"
read name
echo -e "\n${GREEN} Running… ${NC}\n"
create-react-app $name
cd $name
echo "Installing Lodash"
npm i --save lodash
echo "Installing Sass"
npm i --save-dev node-sass-chokidar
npm i --save-dev npm-run-all
echo "# $name" > README.md

# add new scripts to package.json w/ node
node "$THIS_PATH/node-helper.js" "$PWD/package.json"

echo "Copying src template"
rm -fr src
cp -a "$THIS_PATH/templates/src" ./

echo "Copying .editorconfig template"
cp "$THIS_PATH/templates/.editorconfig" "$PWD"

echo "Copying .gitignore template"
cp "$THIS_PATH/templates/.gitignore" "$PWD"

echo "Adding git"
git init "$PWD"
git add README.md
git add package.json
git add package-lock.json
git add public
git add src
git add .gitignore
git add .editorconfig
git commit -m init

open -a Visual\ Studio\ Code .

echo -e "\n${GREEN}Done settign up $name! 🎉${NC}\n"

npm run start
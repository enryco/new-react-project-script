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

echo "Copy src template"
rm -fr src
cp -a "$THIS_PATH/src" ./

echo "Copy .editorconfig template"
cp "$THIS_PATH/.editorconfig" "$PWD"

echo "Adding git"
git init "$PWD"
git add README.md
git add package.json
git add package-lock.json
git add public
git add src
git commit -m init

open -a Visual\ Studio\ Code .

echo -e "\n${GREEN}Done settign up $name! 🎉${NC}\n"

npm run start
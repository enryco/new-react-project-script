const fs = require('fs')

console.log('Running node…')

const packagePath = process.argv[2]

// add scripts
fs.readFile(packagePath, (err, data) => {
  let package = JSON.parse(data)
  package.scripts = {
    "build-css": "node-sass-chokidar src/ -o src/",
    "watch-css": "npm run build-css && node-sass-chokidar src/ -o src/ --watch --recursive",
    "start-js": "react-scripts start",
    "start": "npm-run-all -p watch-css start-js",
    "build-js": "react-scripts build",
    "build": "npm-run-all build-css build-js",
    "test": "react-scripts test --env=jsdom",
    "eject": "react-scripts eject"
  }

  fs.writeFile("./package.json", JSON.stringify(package, null, 2))

})
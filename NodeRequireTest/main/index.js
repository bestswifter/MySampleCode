let path = require('path')
process.env.NODE_PATH = path.resolve(__dirname, '../') ;
require('module').Module._initPaths();

let utils = require('ut')

console.log(utils.key)
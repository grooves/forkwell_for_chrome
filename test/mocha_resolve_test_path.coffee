path = require 'path'

process.env.NODE_PATH = [
  process.env.NODE_PATH,
  path.resolve(__dirname, '..')
].join(':')

require('module').Module._initPaths()

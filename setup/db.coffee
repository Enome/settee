{ Connection } = require 'cradle'

server = new Connection 'http://0.0.0.0', 5984,
  cache: false
  raw: false

module.exports = server.database 'settee'

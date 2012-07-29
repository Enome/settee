qs = require 'querystring'
request = require 'request'

module.exports = (db, ddoc, id, handler, options, callback)->

  if not callback

    callback = options
    options = undefined

  db.update "#{ddoc}/#{handler}", id, options, callback

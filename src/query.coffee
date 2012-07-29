{ EventEmitter } = require 'events'

emitEvents = (eventEmitter, map, error, docs)->

  if error
    return eventEmitter.emit 'error', error

  if docs.length >= 1

    eventEmitter.emit 'one', map docs[0]

  if docs.length is 0

    eventEmitter.emit 'empty'

  eventEmitter.emit 'many', ( ( map doc ) for doc in docs )


extend = (objs...)->

  src = {}

  for obj in objs

    for k, v of obj

      src[k] = v

  src

module.exports = (db, ddoc, queries, globalMap, globalOptions)->

  (query, options)->

    eventEmitter = new EventEmitter

    query = queries[query]

    if not query

      throw new Error 'Query missing error'

    map = query.map or globalMap or (data)->data.value
    options = extend globalOptions, query.options, options

    return {

      commit: ->

        db.view "#{ddoc}/#{query.view}", options, (error, docs)->

          emitEvents eventEmitter, map, error, docs

      on: eventEmitter.on.bind eventEmitter

    }

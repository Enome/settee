{ EventEmitter } = require 'events'

walk = (object, fn)->

  for k, v of object

    fn object, k, v

    if v and typeof v is 'object'

      walk v, fn

extend = (objects)->

  objects = [ objects ] unless Array.isArray objects

  o = {}

  for object in objects

    for k, v of object

      o[k] = v if v

  walk o, (o, k, v)->

    delete o[k] if typeof(v) is 'function'

  o

module.exports = (db, type)->

  (documents)->

    eventEmitter = new EventEmitter

    return {

      on: eventEmitter.on.bind eventEmitter

      commit: ->

        data = extend documents

        if not ( Object.keys data ).length

          return eventEmitter.emit 'error', 'No data to be saved'

        data.created ?= new Date().toUTCString() unless data._rev
        data.modified = new Date().toUTCString()
        data.type = type if type

        cmd = if data._rev then 'merge' else 'save'

        db[cmd] data, (err, res)->

          return eventEmitter.emit 'error', err if err

          data._id = res.id
          data._rev = res.rev

          return eventEmitter.emit 'complete', data

    }

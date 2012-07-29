{ EventEmitter } = require 'events'

module.exports = (db)->

  (doc)->

    eventEmitter = new EventEmitter

    return {

      on: eventEmitter.on.bind eventEmitter

      commit: ->

        { _id, _rev } = doc

        console.log _id, _rev

        db.remove _id, _rev, (err, res)->

          return eventEmitter.emit 'error', err if err

          eventEmitter.emit 'complete', res

    }

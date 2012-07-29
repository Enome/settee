db = require './db'

module.exports =

  deploy: (callback)->

    db.destroy (res)->

      db.create (res)->

        ddoc =
          views: require './views'

        db.save '_design/general', ddoc, callback

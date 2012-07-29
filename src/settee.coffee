Save = ( require './save' )
Remove = ( require './remove' )
Query = ( require './query' )
update = ( require './update' )

Settee = (db, ddoc, options)->

  save: ( Save db, options?.type )
  remove: ( Remove db )
  query: ( Query db, ddoc, options?.queries, options?.map, options?.options )
  update: ( update.bind null, db, ddoc )

module.exports = Settee

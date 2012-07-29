module.exports =
  'findProductByEmail':
    map: (doc)->
      emit doc.email, doc

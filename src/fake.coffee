{ EventEmitter } = require 'events'
sinon = require 'sinon'

module.exports = (event, args...)->

  ee = new EventEmitter

  query: sinon.stub().returns

    on: ee.on.bind ee

    commit: ->

      ee.emit event, args...

  save: sinon.stub().returns

    on: ee.on.bind ee

    commit: ->

      ee.emit event, args...

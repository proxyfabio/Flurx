Stream = require('../core/Stream.kefir').Stream
CoreStore = require '../core/Store.kefir'
DepStore = require './DependentStore'
SDepStore = require './SecondDependentStore'

class Store extends CoreStore
  constructor: (args) ->
    @text = 333

  getData: () ->
    {text: @text}

Store = new Store()

Stream.addAction Store, 'change', (args) ->
  Store.text = args
  Store.emitChange()
, [DepStore, SDepStore]

module.exports = Store

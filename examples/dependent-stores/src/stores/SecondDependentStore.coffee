Stream = require('../core/Stream.kefir').Stream
CoreStore = require '../core/Store.kefir'
DepStore = require './DependentStore'

class SDepStore extends CoreStore
  constructor: (args) ->
    @text = 888

  getData: () ->
    {text: @text}

SDepStore = new SDepStore()

Stream.addAction SDepStore, 'change', (args) ->
  SDepStore.text = args
  SDepStore.emitChange()
, [DepStore]

module.exports = SDepStore

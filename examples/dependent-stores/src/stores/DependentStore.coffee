Stream = require('../core/Stream.kefir').Stream
CoreStore = require '../core/Store.kefir'
kefir = require 'kefir'

class DepStore extends CoreStore
  constructor: (args) ->
    @text = 555

  getData: () ->
    {text: @text}

DepStore = new DepStore()

Stream.addAction DepStore, 'change', (args) ->
  DepStore.text = args
  DepStore.emitChange()


module.exports = DepStore

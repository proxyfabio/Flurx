kefir = require 'kefir'

class Store
  _token: null
  _emitter: kefir.emitter()

  emitChange: () ->
    @_emitter.emit()

module.exports = Store

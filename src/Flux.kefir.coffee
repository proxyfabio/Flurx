module.exports =
  fluxUpdateStore: (callbackConsumer) ->
    called = false
    kefir.fromBinder((emitter) ->
      if !called
        callbackConsumer (fn, x) ->
          emitter.emit fn x
          emitter.end()
          return
        called = true
      return
    ).setName 'fluxUpdateStore'

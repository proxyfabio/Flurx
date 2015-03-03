Stream = require('../core/Stream.kefir').Stream
Action = require '../core/Action.kefir'
kefir = require '../core/flux.kefir'

create = Action.create()

module.exports =
  input: (data) ->
    action = 'change'
    Stream
      .src(create data)
      .filter (v) ->
        Number(v) is 777
      .onValue (x) ->
        kefir
          .sequentially 0, Stream.getActionSequence action
          .flatMapConcat (fn) -> #fn(x)
            kefir.fluxUpdateStore (callback) -> callback( fn , x )
          .onEnd ->

  # imitates API request
  inputAsync: (data) ->
    action = 'change'
    kefir
      .fromCallback (callback) ->
        setTimeout ->
          callback( create data )
        , 2000
      .filter (v) ->
        Number(v) is 777
      .onValue (x) ->
        kefir
          .sequentially 0, Stream.getActionSequence action
          .flatMapConcat (fn) -> #fn(x)
            kefir.fluxUpdateStore (callback) -> callback( fn , x )
          .onEnd ->

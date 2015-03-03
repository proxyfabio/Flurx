kefir = require 'kefir'
SimpleStream = (value) ->
  @_actions = {}
  @_prefix = ''
  @_id = 1

  return @

SimpleStream.prototype =
  src: (action) ->
    kefir.fromBinder (emitter) ->
      emitter.emit action

  registerSubscriber: (subscriber, key) ->
    token = subscriber._token
    return token if token

    id = @_prefix + @_id++
    subscriber._token = id
    return id

  addAction: (store, actionName, fn, deps) ->
    id = @registerSubscriber store

    if !@_actions[actionName] then @_actions[actionName] = {}
    @_actions[actionName][id] = {fn, deps}

  getActionSequence: (actionName) ->
    seq = []

    _originalActions = @_actions[actionName]
    if !_originalActions then return

    # get tmp actions
    _tmpActions = {}
    Object.keys(_originalActions).map (v, key) ->
      action = _originalActions[v]
      if !action then return
      @[v] = {fn: action.fn}
    , _tmpActions

    Object.keys(_originalActions).map (v, key) ->
      action = _originalActions[v]
      if !action then return

      # if don't have deps
      if !action.deps
        _tmpActions[v]._processed = yes
        seq.push action.fn

      # if they are
      else
        _depsWereProcessed = 0
        action.deps.map (store) ->
          if _tmpActions[store._token]._processed then _depsWereProcessed++

        if action.deps.length is _depsWereProcessed
          seq.push action.fn
          _tmpActions[v]._processed = yes

    , @

    return seq

module.exports =
  Stream: new SimpleStream()

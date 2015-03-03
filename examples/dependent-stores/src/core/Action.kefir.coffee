module.exports =
  create: (handler) ->
    action = (data) ->
      if typeof handler is 'function'
        value = handler data
      else
        value = data

      value

    return action

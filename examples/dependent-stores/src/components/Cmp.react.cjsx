React = require "react"
Actions = require "../actions/Actions"
Store = require "../stores/Store"
DepStore = require "../stores/DependentStore"
SecondDepStore = require "../stores/SecondDependentStore"
kefir = require "kefir"

module.exports = React.createClass
  getInitialState: (args) ->
    @_pool = kefir.pool()
    @_pool.onAny (args) => @onChange()

    text: Store.getData().text
    deptext: DepStore.getData().text
    sdeptext: SecondDepStore.getData().text

  componentDidMount: (args) ->
    @_pool.plug Store._emitter
    @_pool.plug DepStore._emitter
    @_pool.plug SecondDepStore._emitter

  componentWillUnmount: (args) ->
    @_pool.unplug Store._emitter
    @_pool.unplug DepStore._emitter
    @_pool.unplug SecondDepStore._emitter

  onChange: (args) ->
    @setState
      text: Store.getData().text
      deptext: DepStore.getData().text
      sdeptext: SecondDepStore.getData().text

  handleChange: (e) ->
    Actions.input e.target.value

  render: () ->
    <div>
      <input type="text" placeholder="type in 777" onChange={@handleChange} />
      <div>{@state.text}</div>
      <div>{@state.deptext}</div>
      <div>{@state.sdeptext}</div>
    </div>

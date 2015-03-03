React = require 'react'
Cmp = require "../components/Cmp.react"

document.addEventListener 'DOMContentLoaded',(args) ->
  React.render <Cmp />, document.getElementById 'main'

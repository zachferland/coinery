Template = require 'templates/nav'

module.exports = class Header extends Backbone.View

  el: '.nav-container'

  events: ->
    'click a': 'navHandler'

  initialize: ->
    @user = @model

  render: ->
    ctx = {} # @user.attributes
    @$el.html Template ctx

  navHandler: (e) ->
    do e.preventDefault
    alert "going to #{$(e.target).text()}"


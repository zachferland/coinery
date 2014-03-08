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
    dest = $(e.target).attr 'data-href'
    Backbone.history.navigate dest, {trigger: true}

  setActive: (route) ->
    @$('li').removeClass 'current'
    $("a[data-href=#{route}]").parent().addClass 'current'

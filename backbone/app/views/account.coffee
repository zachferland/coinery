Template = require 'templates/account'

module.exports = class AccountView extends Backbone.View

  el: '.main-container'

  events: ->

  initialize: ->
    @user = @model

  render: ->
    ctx = {}
    @$el.html Template ctx


Template = require 'templates/account'

module.exports = class AccountView extends Backbone.View

  el: '.content'

  events: ->

  initialize: ->
    @user = @model

  render: ->
    ctx = {}
    @$el.html Template ctx


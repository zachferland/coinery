Template = require 'templates/customers'

module.exports = class CustomersView extends Backbone.View

  el: '.main-container'

  events: ->

  initialize: ->
    @user = @model

  render: ->
    ctx = {}
    @$el.html Template ctx


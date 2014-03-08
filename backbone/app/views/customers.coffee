Template = require 'templates/customers'

module.exports = class CustomersView extends Backbone.View

  el: '.content'

  events: ->
    'click a': 'linkHandler'

  initialize: ->
    @user = @model

  render: ->
    ctx = {}
    @$el.html Template ctx

  linkHandler: (e) ->
    do e.preventDefault
    dest = $(e.target).attr 'data-href'
    Backbone.history.navigate dest


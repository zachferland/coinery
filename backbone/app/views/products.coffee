Template = require 'templates/products'

module.exports = class ProductsView extends Backbone.View

  el: '.main-container'

  events: ->

  initialize: ->
    @user = @model

  render: ->
    ctx = {}
    @$el.html Template ctx


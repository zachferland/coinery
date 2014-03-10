Template = require 'templates/products'

module.exports = class ProductsView extends Backbone.View

  el: '.content'

  events: ->
    'click a': 'linkHandler'

  initialize: (options) ->
    @user = @model

  render: ->
    ctx =
      'username': @user.getTwitterHandle()
      'products': @user.getProducts()

    @$el.html Template ctx

  linkHandler: (e) ->
    do e.preventDefault
    dest = $(e.target).attr 'data-href'
    Backbone.history.navigate dest, {trigger: true}



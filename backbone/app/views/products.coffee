Template = require 'templates/products'

module.exports = class ProductsView extends Backbone.View

  el: '.content'

  events: ->
    'click a': 'linkHandler'

  initialize: (options) ->
    @user = options.user

  render: ->
    ctx =
      'username': @user.getTwitterHandle()
      'products': null

    @$el.html Template ctx

  linkHandler: (e) ->
    do e.preventDefault
    dest = $(e.target).attr 'data-href'
    Backbone.history.navigate dest, {trigger: true}



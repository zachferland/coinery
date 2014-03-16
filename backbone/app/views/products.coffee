Template = require 'templates/products'

module.exports = class ProductsView extends Backbone.View

  el: '.content'

  events: ->
    'click a': 'linkHandler'
    'click a[data-href="delete"]': 'deleteHandler'
    'click a[data-href="edit-product"]': 'editHandler'
    'click a[data-href="new-product"]': 'newHandler'

  initialize: (options) ->
    @user = options.user

  render: ->
    console.log 'render'
    ctx =
      'username': @user.getTwitterHandle()
      'products': []

    # serialize product data
    for model in @collection.models
      product = {}
      product.id = model.id
      product.title = model.getTitle()
      product.price = model.getPrice()
      product.cover = model.getCoverURL()
      ctx['products'].push product

    @$el.html Template ctx

    do @postRender

  postRender: ->
    @$('ul.products-list li').each (i, el) ->
      $(el).find('.dropdown-toggle').dropdown()

  deleteHandler: (e) ->
    do e.preventDefault
    $el = $(e.target).closest('li.product-container')
    id = $el.attr 'data-product-id'
    model = @collection.get(id)
    model.destroy
      url: "/api/products/#{id}"
      success: (response) =>
        @collection.remove(model)
        $el.fadeOut =>
          do @render

  newHandler: (e) ->
    Backbone.history.navigate "products/new", {trigger: true}

  editHandler: (e) ->
    do e.preventDefault
    id = $(e.target).closest('li.product-container').attr 'data-product-id'
    Backbone.history.navigate "products/edit/#{id}", {trigger: true}

  linkHandler: (e) ->
    do e.preventDefault
    dest = $(e.target).attr 'data-href'
    Backbone.history.navigate dest, {trigger: true}



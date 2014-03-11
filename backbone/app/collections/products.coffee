Product = require 'models/product'

module.exports = class Products extends Backbone.Collection

  url: '/api/products'

  model: Product

  initialize: (options) ->

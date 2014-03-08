Product = require 'models/product'

module.exports = class Products extends Backbone.Collection

  url: ''

  model: Product

  initialize: (options) ->

Router = require 'router'
User = require 'models/user'
Products = require 'collections/products'
Product = require 'models/product'

module.exports =
  start: ->

    products = new Products

    user = new User
      first_name: 'David'
      products: products

    user.fetch
      async: false
      success: (response) ->
        console.log response
      error: (xhr, status, error) ->
        console.log xhr, status

    router = new Router { user }
    do Backbone.history.start

module.exports = class Product extends Backbone.Model

  url: 'api/products'
  urlRoot: 'api/products'

  initialize: (options) ->

  setName: (name) ->
    @set 'name', name

  getName: ->
    @get 'name'

  setPrice: (price) ->
    @set 'price', price

  getPrice: ->
    @get 'price'

  log: ->
    console.log @attributes



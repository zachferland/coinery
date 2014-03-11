module.exports = class Product extends Backbone.Model

  url: '/api/products'

  urlRoot: '/api/products'

  defaults:
    'title': ''
    'description': ''
    'price': parseFloat('')

  initialize: (options) ->

  setName: (name) ->
    @set 'name', name

  getName: ->
    @get 'name'

  setPrice: (price) ->
    @set 'price', price

  getPrice: ->
    @get 'price'

 toJSON: ->
   json = {}
   json['product'] = _.clone(@.attributes)
   return json


  log: ->
    console.log @attributes



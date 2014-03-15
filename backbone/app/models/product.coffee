module.exports = class Product extends Backbone.Model

  url: -> '/api/products'
  urlRoot: -> '/api/products'

  defaults:
    'title': ''
    'description': ''
    'price': "0"

  initialize: (options) ->

  # GETTERS/SETTERS

  setTitle: (title) ->
    @set 'title', title

  getTitle: ->
    @get 'title'

  setPrice: (price) ->
    @set 'price', price

  getPrice: ->
    @get 'price'

  getDescription: ->
    @get 'description'

  setDescription: (description) ->
    @set 'description', description

  getReadableStatus: ->
    status = @get('status')
    switch status
      when 0
        return "???"
      when 1
        return "Draft"
      when 2
        return "Draft"
      when 3
        return "Live"
    "unkown"





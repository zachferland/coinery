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

  getCoverURL: ->
    @get 'image_url'

  setDescription: (description) ->
    @set 'description', description

  setStatus: (status) ->
    @set 'status', status

  getPublished: ->
    return true if @get('status') is 2
    false

  getReadableStatus: (e) ->
    s = ''
    switch @get('status')
      when 0
        s = 'Not yet created'
      when 1
        s = 'Draft'
      when 2
        s = 'Published'
    return s


  setAssets: (array) ->
    @set 'assets', array

  getAssets: ->
    @get 'assets'

  getAssetsFromServer: ->
    $.ajax "/api/products/#{@id}/assets",
      method: 'GET'
      async: false
      success: (response) =>
        @setAssets(response)
        @trigger 'fetched_assets'

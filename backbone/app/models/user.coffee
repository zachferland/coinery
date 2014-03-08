module.exports = class User extends Backbone.Model

  url: ''

  initialize: (options) ->


  getProducts: ->
    @get('products').toJSON()

  displayName: ->
    @get('first_name')+ " " + @get('last_name')


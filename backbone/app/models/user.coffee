module.exports = class User extends Backbone.Model

  url: '/user'

  initialize: (options) ->


  getProducts: ->
    @get('products').toJSON()

  displayName: ->
    @get('first_name')+ " " + @get('last_name')


module.exports = class User extends Backbone.Model

  url: 'api/user'

  initialize: (options) ->

  setValidSession: ->
    @set 'valid_session', true

  getValidSession: ->
    @get 'valid_session'

  getTwitterHandle: ->
    "@#{@get('username')}"

  getProducts: ->
    null

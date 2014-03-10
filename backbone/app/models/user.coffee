module.exports = class User extends Backbone.Model

  url: '/user'

  initialize: (options) ->

  setValidSession: ->
    @set 'valid_session', true

  getValidSession: ->
    @get 'valid_session'

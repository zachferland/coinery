module.exports = class User extends Backbone.Model

  url: '/api/user'

  initialize: (options) ->

  getName: ->
    @get 'full_name'

  setValidSession: ->
    @set 'validated_session', true

  getValidSession: ->
    @get 'validated_session'

  getTwitterHandle: ->
    "@#{@get('username')}"


module.exports = class User extends Backbone.Model

  url: '/api/user'

  initialize: (options) ->
    @on 'change', console.log(@attributes)

  setValidSession: ->
    @set 'validated_session', true

  getValidSession: ->
    @get 'validated_session'

  getTwitterHandle: ->
    "@#{@get('username')}"


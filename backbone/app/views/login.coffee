Template = require 'templates/login'

module.exports = class LoginView extends Backbone.View

  el: '.content'

  events: ->

  initialize: ->
    @user = @model

  render: ->
    @$el.html Template {}


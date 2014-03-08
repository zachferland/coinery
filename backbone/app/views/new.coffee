Template = require 'templates/new'

module.exports = class NewProductView extends Backbone.View

  el: '.content'

  events: ->

  initialize: (options) ->
    @user = @model

  render: ->
    @$el.html Template {}


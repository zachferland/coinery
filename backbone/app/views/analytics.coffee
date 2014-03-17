Template = require 'templates/analytics'

module.exports = class AnalyticsView extends Backbone.View

  el: '.content'

  initialize: ->
    @user = @model

  render: ->
    ctx = {}
    @$el.html Template ctx



OverlayView = require 'views/overlay'
Template = require 'templates/edit'

module.exports = class EditProductView extends Backbone.View

  el: '.content'

  events: ->
    'a[data-href="save"]': 'saveHandler'
    'a[data-href="publish"]': 'publishHandler'

  initialize: (options) ->
    @user = options.user

  render: ->
    ctx =
      'title': @model.getTitle()

    @$el.html Template ctx

    do @renderOverlay


  renderOverlay: ->
    overlay = new OverlayView
      user: @user
      model: @model
    overlay.render()









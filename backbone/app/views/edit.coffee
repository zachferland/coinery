OverlayView = require 'views/overlay'
Template = require 'templates/edit'

module.exports = class EditProductView extends Backbone.View

  el: '.content'

  events: ->
    'click a[data-href="save"]': 'saveHandler'
    'click a[data-href="publish"]': 'publishHandler'

  initialize: (options) ->
    @user = options.user

  render: ->
    ctx =
      'title': @model.getTitle()

    @$el.html Template ctx

    do @renderOverlay


  publishHandler: (e) ->
    do e.preventDefault
    console.log 'handler called'
    @model.save "/api/products/#{@model.get('id')}/publish",
      success: (response) ->
        console.log 'hey'

  renderOverlay: ->
    overlay = new OverlayView
      user: @user
      model: @model
    overlay.render()









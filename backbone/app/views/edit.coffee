OverlayView = require 'views/overlay'
FilesView = require 'views/files'
Template = require 'templates/edit'

module.exports = class EditProductView extends Backbone.View

  el: '.content'

  events: ->
    'click a[data-href="save"]': 'saveHandler'
    'click a[data-href="publish"]': 'publishHandler'
    'click a[data-href="coinbase-auth"]': 'coinbaseAuthHandler'

  initialize: (options) ->
    @user = options.user

  render: ->
    ctx =
      'title': @model.getTitle()
      'has_coinbase_auth': @user.getCoinbaseAuth()

    @$el.html Template ctx

    do @renderOverlay
    do @renderFiles


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


  renderFiles: ->
    files = new FilesView
      user: @user
      model: @model
    files.render()

  coinbaseAuthHandler: (e) ->
    do e.preventDefault
    window.location.href = window.coinbase_url









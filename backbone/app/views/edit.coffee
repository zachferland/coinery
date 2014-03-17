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
    console.log @product

  render: ->
    ctx =
      'title': @model.getTitle()
      'description': @model.getDescription()
      'has_coinbase_auth': @user.getCoinbaseAuth()

    @$el.html Template ctx

    do @renderSubviews


  renderSubviews: ->
    do @renderOverlay
    do @renderFiles


  killSubviews: ->
    for view in [@overlay, @files]
      if view?
        do view.undelegateEvents
        view.$el.html ''

  saveHandler: (e) ->
    title = $('input[data-id="title"]').val()
    @model.setTitle(title)

    price = $('input[data-id="price"]').val().replace '$', ''
    @model.setPrice(price)

    description = $('div[data-id="description"]').html()
    @model.setDescription(description)

    @model.save {},
      url: "/api/products/#{@model.id}"
      async: false
      success: (response) =>
        do @overlay.render


  publishHandler: (e) ->
    do e.preventDefault

    do @saveHandler

    unless @user.getCoinbaseAuth()
      @$('.coinery-cta').show ->
        $(this).addClass 'visible'
        return

    @model.setStatus(2)
    @model.save {},
      url: "/api/products/#{@model.get('id')}/publish"
      success: (response) =>
        unless @overlay?
          do @renderOverlay
          return
        do @overlay.render


  renderOverlay: ->
    @overlay = new OverlayView
      user: @user
      model: @model
    @overlay.render()


  renderFiles: ->
    @files = new FilesView
      user: @user
      model: @model
    @files.render()

  coinbaseAuthHandler: (e) ->
    do e.preventDefault
    window.open window.cb_auth_url
    window.addEventListener "focus", (event) =>
      @user.fetch
        success: (response) =>
          if @user.getCoinbaseAuth
            do @render
    , false











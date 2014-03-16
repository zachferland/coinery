Template = require 'templates/overlay'

module.exports = class OverlayView extends Backbone.View

  el: '.overlay-container'

  events: ->
    'focus input': 'inputFocusHandler'
    'blur input': 'resetFocus'
    'click [contenteditable]': 'contentEditableFocus'
    'keyup .field-wrapper input': 'currencyHandler'
    'keydown .field-wrapper input': 'currencyValidateHandler'

  initialize: (options) ->
    @user = options.user

  render: ->
    ctx =
      'id': @model.id
      'title': @model.getTitle()
      'description': @model.getDescription()
      'price': @model.getPrice()
      'user_name': @user.getName()
      'status': @model.getReadableStatus()

    @$el.html Template ctx

    do @postRender

  postRender: ->
    do @dropzoneInit
    do @fillPrice

  fillPrice: ->
    rate = 610
    price = @model.getPrice()
    $('[data-currency="BTC"] input').val "#{parseFloat(price)*rate}"
    $('[data-currency="USD"] input').val "$#{parseFloat(price)}"

  resetFocus: ->
    @$('.price-container').removeClass 'usd-focus btc-focus focus'
    @$('.field-container').removeClass 'editing-price'
    @$('.title-container').removeClass 'focus'
    @$('.description').removeClass 'focus'

  contentEditableFocus: (e) ->
    $(e.target).addClass 'focus'

  inputFocusHandler: (e) ->
    do @resetFocus
    if e.target.className in ['usd', 'btc']
      @$('.price-container').addClass "#{e.target.className}-focus focus"
      @$('.field-container').addClass 'editing-price'
    else
      @$('.title-container').addClass "focus"


  currencyHandler: (e) ->

    return if e.keyCode is 190

    inputs =
      'btc': $('[data-currency="BTC"] input')
      'usd': $('[data-currency="USD"] input')

    focus = $(e.target).parent().attr 'data-currency'
    rate = 640

    raw = $(e.target).val().replace '$', ''
    amount = parseFloat(raw)

    if focus is 'BTC'
      usd = amount * 640
      unless isNaN(usd)
        inputs.usd.addClass 'changing'
        console.log 'changing'
        delay 150, ->
          inputs.usd.val "$#{usd.toString()}"
        delay 300, ->
          inputs.usd.removeClass 'changing'

    if focus is 'USD'
      btc = amount / 640
      unless isNaN(btc)
        inputs.btc.addClass 'changing'
        delay 150, ->
          inputs.btc.val btc.toFixed(5)
        delay 300, ->
          inputs.btc.removeClass 'changing'

      unless isNaN(amount)
        inputs.usd.val "$#{amount.toString()}"


  dropzoneInit: ->

    dropzone = new Dropzone 'a[data-href="cover-dropzone"]',
      previewsContainer: '.dz-cover-preview-container'
      url: "/api/products/#{@model.get('id')}"
      paramName: 'image'
      method: 'put'

    # update percentage count
    dropzone.on 'uploadprogress', (file, progress, bytesSent) ->
      $('.dz-progress-percent').text Math.round(progress) + "%"

    # believe it or not this breaks without the console.log
    dropzone.on 'addedFile', (file) ->
      console.log file

  backHandler: ->
    Backbone.history.navigate "products", {trigger: true}





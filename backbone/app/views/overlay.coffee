Template = require 'templates/overlay'

module.exports = class OverlayView extends Backbone.View

  el: '.overlay-container'

  events: ->
    'focus input': 'inputFocusHandler'
    'blur input': 'resetFocus'
    'click [contenteditable]': 'contentEditableFocus'
    'keyup .field-wrapper input': 'currencyHandler'
    'keydown .field-wrapper input': 'currencyValidateHandler'
    'keydown': 'showWarning'

  initialize: (options) ->
    @user = options.user
    @warningVisible = false

  render: ->
    ctx =
      'id': @model.id
      'title': @model.getTitle()
      'description': @model.getDescription()
      'cover': @model.getCoverURL()
      'price': @model.getPrice()
      'user_name': @user.getName()
      'status': @model.getReadableStatus()

    @$el.html Template ctx

    do @postRender

  showWarning: (e) ->
    return if @warningVisible
    $('.unsaved').addClass 'visible'

  postRender: ->
    do @dropzoneInit
    do @fillPrice

  fillPrice: ->
    rate = window.conversion_rate
    if not rate
      rate = (1/540)

    price = @model.getPrice()
    if price?
      btc_float = price * rate
      usd = parseFloat(price).toFixed(2)
      btc = parseFloat(btc_float.toFixed(3))
      $('[data-currency="BTC"] input').val btc
      $('[data-currency="USD"] input').val usd
      return

  resetFocus: ->
    @$('.price-container').removeClass 'usd-focus btc-focus focus'
    @$('.field-container').removeClass 'editing-price'
    @$('.title-container').removeClass 'focus'
    @$('.description').removeClass 'focus'

  contentEditableFocus: (e) ->
    $(e.target).addClass 'focus'
    if /Add a description/.test($(e.target).html())
      do $(e.target).selectText

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

    rate = window.conversion_rate
    if not rate
      rate = (1/540)

    raw = $(e.target).val().replace '$', ''
    amount = parseFloat(raw)

    if focus is 'BTC'
      usd = amount / rate
      unless isNaN(usd)
        inputs.usd.addClass 'changing'
        console.log 'changing'
        delay 150, ->
          inputs.usd.val "$#{usd.toFixed(2).toString()}"
        delay 300, ->
          inputs.usd.removeClass 'changing'

    if focus is 'USD'
      btc = amount * rate
      unless isNaN(btc)
        inputs.btc.addClass 'changing'
        delay 150, ->
          inputs.btc.val parseFloat(btc.toFixed(5))
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





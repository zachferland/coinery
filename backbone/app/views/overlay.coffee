Template = require 'templates/overlay'
DropzoneTemplate = require 'templates/dropzone'

module.exports = class OverlayView extends Backbone.View

  el: '.overlay-container'

  events: ->
    'focus input': 'inputFocusHandler'
    'blur input': 'resetFocus'
    'click [contenteditable]': 'contentEditableFocus'
    'keyup input.currency': 'currencyHandler'
    'keydown input.currency': 'currencyValidateHandler'

  initialize: (options) ->
    @user = options.user

  render: ->
    ctx =
      'id': @model.id
      'title': @model.getTitle()
      'description': @model.getDescription()
      'price': @model.getPrice()
      'user_name': @user.getName()

    @$el.html Template ctx

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

    # @override: update width of progress bar
    uploadprogress = (file, progress, bytesSent) ->

      ref = file.previewElement.querySelectorAll "[data-dz-uploadprogress]"
      width = "#{100 - parseInt(progress)}%"

      results = []
      i = 0

      while i < ref.length
        node = ref[i]
        results.push node.style.width = width
        i++

      results

    # @override: human readable file size
    filesize = (size) ->
      if size >= Math.pow(1024, 4) / 10
        size = size / (Math.pow(1024, 4) / 10)
        string = "TB"
      else if size >= Math.pow(1024, 3) / 10
        size = size / (Math.pow(1024, 3) / 10)
        string = "GB"
      else if size >= Math.pow(1024, 2) / 10
        size = size / (Math.pow(1024, 2) / 10)
        string = "MB"
      else if size >= 1024 / 10
        size = size / (1024 / 10)
        string = "KB"
      else
        size = size * 10
        string = "b"

      "<strong>#{Math.round(size)/10}</strong>#{string}"


    # apply overrides to dropzone obj
    Dropzone::defaultOptions.uploadprogress = uploadprogress
    Dropzone::filesize = filesize


    # init dropzone with custom template
    dropzone = new Dropzone 'a[data-href="dropzone"]',
      previewsContainer: '.dz-preview-container'
      previewTemplate: DropzoneTemplate {}
      url: '#'

    # update percentage count
    dropzone.on 'uploadprogress', (file, progress, bytesSent) ->
      $('.dz-progress-percent').text Math.round(progress) + "%"

    # believe it or not this breaks without the console.log
    dropzone.on 'addedFile', (file) ->
      console.log file


  backHandler: ->
    Backbone.history.navigate "products", {trigger: true}





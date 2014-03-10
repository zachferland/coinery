Template = require 'templates/new'
DropzoneTemplate = require 'templates/dropzone'

module.exports = class NewProductView extends Backbone.View

  el: '.content'

  events: ->
    'click a[data-href="back"]': 'backHandler'
    'click a[data-href="save"]': 'saveHandler'
    'keyup input.currency': 'currencyHandler'
    'keydown input.currency': 'currencyValidateHandler'

  initialize: (options) ->
    @user = @model

  render: ->
    @$el.html Template {}

    do @postRender


  postRender: ->
    @$('input').focus()

    do @dropzoneInit


  saveHandler: (e) ->
    do e.preventDefault

    console.log 'saveHandler called'

    $currentStep = $(e.target).closest('.fieldset')
    console.log $currentStep
    errors = 0

    $currentStep.find('[required]').each (i, el) ->
      console.log 'called'
      $(el).removeClass 'error'
      if $(el).val() is ''
        $(el).addClass 'error'
        console.log 'error'
        errors++

    unless errors > 0
      $currentStep.addClass('complete')
                 .next().removeClass 'hidden'

    return false


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


    dropzone.on 'addedFile', (file) ->
      console.log file


  backHandler: ->
    Backbone.history.navigate "products", {trigger: true}





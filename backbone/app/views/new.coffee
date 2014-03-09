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
    focus = $(e.target).parent().attr 'data-currency'

    currencies =
      'USD': $('[data-currency="USD"] input')
      'BTC': $('[data-currency="BTC"] input')

    if focus is 'USD'
      val = currencies['USD'].val()

      unless val.indexOf('$') > -1
        currencies['USD'].val "$#{val}"

    console.log currencies['BTC'].val()
    console.log currencies['USD'].val()


  # don't let user delete $ from USD input
  # number inputs only
  currencyValidateHandler: (e) ->

    if e.keyCode in [46, 8]
      if $(e.target).val().length is 1
        return true
      else
        return false

    char = String.fromCharCode(e.keyCode)
    regex = /[0-9]|\./

    if regex.test(char)
      return true

    false

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





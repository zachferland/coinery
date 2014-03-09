Template = require 'templates/new'
DropzoneTemplate = require 'templates/dropzone'

module.exports = class NewProductView extends Backbone.View

  el: '.content'

  events: ->
    'click a[data-href="back"]': 'backHandler'

  initialize: (options) ->
    @user = @model

  render: ->
    @$el.html Template {}

    do @postRender


  postRender: ->
    @$('input').focus()

    do @dropzoneInit

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





Template = require 'templates/files'
DropzoneTemplate = require 'templates/dropzone-edit'

module.exports = class FilesView extends Backbone.View

  el: '.files-container'

  events: ->
    'click a[data-href="remove-file"]': 'fileDeleteHandler'
    'click a[data-href="trigger-dz"]': 'triggerDropzoneHandler'

  initialize: (options) ->
    @user = options.user
    @model.getAssetsFromServer()

  render: ->
    @$el.html Template {}
    do @dropzoneInit



  triggerDropzoneHandler: (e) ->
    do e.preventDefault
    console.log 'trying this'
    do window.jQuery('a[data-href="dropzone"]')[0].click


  dropzoneInit: ->

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


    Dropzone::filesize = filesize


    # init dropzone with custom template
    dropzone = new Dropzone 'a[data-href="dropzone"]',
      paramName: 'asset'
      previewsContainer: '.dz-preview-container'
      previewTemplate: DropzoneTemplate {}
      url: "#"


    url = => "/api/products/#{@model.get('id')}/assets"
    dropzone.options.url = url()

    for asset in @model.getAssets()
      file = {}
      file['name'] = asset.asset_file_name
      file['size'] = asset.asset_file_size
      file['id'] = asset.id
      dropzone.emit "addedfile", file
      dropzone.emit "success", file
      dropzone.files.push file

    setIDs = ->
      for file in dropzone.files
        file.previewElement.setAttribute "data-file-id", file.id

    do setIDs

    dropzone.on 'success', (file, response) ->
      file.id = response['id']
      do setIDs


  fileDeleteHandler: (e) ->
    $el = $(e.target).closest('.dz-preview')
    id = $el.attr 'data-file-id'
    $.ajax "/api/assets/#{id}",
      type: "DELETE"
      success: (response) =>
        @model.getAssetsFromServer()
        do @render


  backHandler: ->
    Backbone.history.navigate "products", {trigger: true}









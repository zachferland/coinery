Template = require 'templates/new'

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

  backHandler: ->
    Backbone.history.navigate "products", {trigger: true}




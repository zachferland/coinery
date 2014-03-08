SidebarView = require 'views/nav'
ProductsView = require 'views/products'
CustomersView = require 'views/customers'
AccountView = require 'views/account'

module.exports = class Router extends Backbone.Router
  routes: ->
    'products': 'productsHandler'
    'customers': 'customersHandler'
    'account': 'accountHandler'

  initialize: (options) ->
    @user = options.user

    @on 'route', window.sexyHash

    nav = new SidebarView
      model: @user
    nav.render()

    # current view in .main-container
    @view = null



  productsHandler: ->
    products = new ProductsView
      model: @user
    @loadView(products)

  customersHandler: ->
    customers = new CustomersView
      model: @user
    @loadView(customers)

  accountHandler: ->
    account = new AccountView
      model: @user
    @loadView(account)


  # safely replace view in .main-container
  loadView: (view) ->

    replace = ->
      @view = view
      @view.render()

    unless @view?
      replace()
      return

    # need to clean up exisiting view
    @view.undelegateEvents()
    @view.remove()
    replace()



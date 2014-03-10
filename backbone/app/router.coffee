SidebarView = require 'views/nav'
ProductsView = require 'views/products'
CustomersView = require 'views/customers'
NewProductView = require 'views/new'
AccountView = require 'views/account'
Product = require 'models/product'

module.exports = class Router extends Backbone.Router
  routes: ->
    'products': 'productsHandler'
    'products/new': 'newProductHandler'
    'customers': 'customersHandler'
    'account': 'accountHandler'
    '*a': 'productsHandler'

  initialize: (options) ->
    @user = options.user

    @on 'route', window.sexyHash

    nav = new SidebarView
      model: @user
    nav.render()

    # go to bed David jesus christ
    @on 'route', (router, route) =>
      nav.setActive router.replace('Handler', '')

    # current view in .main-containerk
    @view = null


  productsHandler: ->

    view = new ProductsView
      model: @user

    @loadView(view)

  customersHandler: ->
    customers = new CustomersView
      model: @user
    @loadView(customers)

  accountHandler: ->
    account = new AccountView
      model: @user
    @loadView(account)

  newProductHandler: ->
    product = new Product
    view = new NewProductView
      user: @user
      model: product
    @loadView(view)


  # safely replace view in .main-container
  loadView: (view) ->

    setVisibility = (show) ->
      if show
        $('.main-container').addClass 'visible'
      else
        $('.main-container').removeClass 'visible'

    replace = =>
      @view = view
      @view.render()
      setVisibility(true)

    if @view?
      setVisibility(false)

    unless @view
      replace()
      setVisibility(true)
      return

    delay 210, =>
      @view.undelegateEvents()
      @view.$el.html ''
      replace()


console.log "this is working"

delay = (ms, func) ->
  setTimeout func, ms

$ ->


  bindings =
    '[data-price-btc]': 'btc'
    'span[data-price-usd]': 'price'
    'h1[data-product-title]': 'title'
    'span[data-user-name]': 'user.full_name'
    'span[data-product-description]': 'description'

  product = {}
  product.btc = 0.00013
  product.usd = 124.235523
  product.user = {full_name: 'David Oates', img: "http://pbs.twimg.com/profile_images/1419786039/profileimage_normal.gif"}
  product.title = "David's First Product"
  product.description = """
    As a thank you for pre-ordering "The Blessed Unrest", I want you to have THREE free downloads, and the entirety of the brand new album!!<br>
    I'm so excited to be sharing the new music, and thank you a million times over for your support.
  """

  product.assets = [{
    asset_file_name: "twitter.png"
    asset_file_size: 235235
  }]

  $('[data-price-btc]').each (i, el) ->
    $(el).html parseFloat(product['btc'].toFixed(6)).toString()

  $('[data-price-usd]').each (i, el) ->
    $(el).html parseFloat(product['usd'].toFixed(2)).toString()

  $('[data-user-name]').each (i, el) ->
    $(el).html product.user.full_name

  $('[data-product-title]').each (i, el) ->
    $(el).html product.title

  $('[data-user-avatar]').each (i, el) ->
    $(el).attr 'src', product.user.img

  $('[data-product-description]').each (i, el) ->
    $(el).html product.description

  $('[data-product-details]').each (i, el) ->
    string = "You'll get "
    string += product.assets.length
    if product.assets.length is 1
      string += " #{product.assets[0].asset_file_name.split(".")[1].toUpperCase()} file"
    size = 0
    for asset in product.assets
      size += asset.asset_file_size/1000
    string += ", #{size.toFixed(0)} kb total"

    $(el).html string


  delay 2000, ->
    $('.panel-container').eq(0).removeClass 'visible'
    delay 200, ->
      $('.panel-container').eq(0).hide()
      $('.panel-container').eq(1).show()
      $('.panel-container').eq(1).addClass 'visible'








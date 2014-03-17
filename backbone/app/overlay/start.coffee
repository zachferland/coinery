`
function getURLParameter(name) {
  return decodeURI(
    (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
  );
}
`

delay = (ms, func) ->
  setTimeout func, ms

$ ->

  p_id = getURLParameter('id')

  $.ajax "/api/products/#{p_id}/buy",
     async: false
     success: (response) ->
       window.product = response

  product = window.product
  console.log product

  bindings =
    '[data-price-btc]': 'btc'
    'span[data-price-usd]': 'price'
    'h1[data-product-title]': 'title'
    'span[data-user-name]': 'user.full_name'
    'span[data-product-description]': 'description'

# product = {}
# product.btc = 0.00013
# product.usd = 124.235523
# product.user = {full_name: 'David Oates', img: "http://pbs.twimg.com/profile_images/1419786039/profileimage_normal.gif"}
# product.title = "David's First Product"
# product.description = """
#   As a thank you for pre-ordering "The Blessed Unrest", I want you to have THREE free downloads, and the entirety of the brand new album!!<br>
#   I'm so excited to be sharing the new music, and thank you a million times over for your support.
# """
# product.button_code = "344jhklhdsjf325jkdlsah43"

# product.assets = [{
#   asset_file_name: "twitter.png"
#   asset_file_size: 235235
# }]
#
  $('[data-product-cover]').each (i, el) ->
    $(el).attr 'src', product['image_url']

  $('[data-price-btc]').each (i, el) ->
    $(el).html parseFloat(product['btc'].toFixed(6)).toString()

  $('[data-price-usd]').each (i, el) ->
    $(el).html parseFloat(product['price'].toFixed(2)).toString()

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

  url_root = "https://coinbase.com/inline_payments/"


  advanceStep = ->
    $('.panel-container').eq(0).removeClass 'visible'
    delay 200, ->
      $('.panel-container').eq(0).hide()
      $('.panel-container').eq(1).show()
      $('.panel-container').eq(1).addClass 'visible'
      $('iframe').attr 'src', url_root+product['button_code']

  $('a[data-href="buy"]').click (e) =>
    advanceStep()



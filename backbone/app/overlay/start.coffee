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

  $('.overlay-container').addClass 'visible'
  window.parent.$('body').addClass 'noscroll'


  p_id = getURLParameter('id')

  $.ajax "/api/products/#{p_id}/buy",
     async: false
     success: (response) ->
       window.product = response

  product = window.product

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

  delay 200, ->
    $('.overlay').addClass 'visible'

  url_root = "https://coinbase.com/inline_payments/"

  advanceStep = (current) ->
    $('.panel-container').eq(current).removeClass 'visible'
    delay 200, ->
      $('.panel-container').eq(current).hide()
      $('.panel-container').eq(current+1).show()
      $('.panel-container').eq(current+1).addClass 'visible'
      $('iframe').attr 'src', url_root+product['button_code']

    if current is 1
      $('iframe').remove()
      delay 100, ->
        $('input').focus()

  $('a[data-href="buy"]').click (e) =>
    advanceStep(0)

  receiveMessage = (event) =>
    if event.origin is "https://coinbase.com"
      event_type = event.data.split("|")[0] # "coinbase_payment_complete"
      event_id = event.data.split("|")[1] # ID for this payment type
      if event_type is "coinbase_payment_complete"
        console.log "payment complete"
        advanceStep(1)

  window.addEventListener "message", receiveMessage, false

  $('a[data-href="submit"]').click (e) =>
    email = $('input').val()
    if email is ''
      alert("Email address is required to download purchased files!")
      return

    $.ajax "/api/products/#{product['id']}/purchase?email=#{encodeURIComponent(email)}",
      method: 'POST'
      success: (response) =>
        do advanceStep(2)


  destination = 'http://app.www.coinery.io'
  if /local/.test(window.location.href)
    destination = 'http://localhost:3000'

  $('a[data-href="close"]').click (e) ->
    window.parent.postMessage 'close_preview', destination
    window.parent.$('body').removeClass 'noscroll'













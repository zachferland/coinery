!function(){"use strict";var e="undefined"!=typeof window?window:global;if("function"!=typeof e.require){var t={},r={},n=function(e,t){return{}.hasOwnProperty.call(e,t)},i=function(e,t){var r,n,i=[];r=/^\.\.?(\/|$)/.test(t)?[e,t].join("/").split("/"):t.split("/");for(var o=0,a=r.length;a>o;o++)n=r[o],".."===n?i.pop():"."!==n&&""!==n&&i.push(n);return i.join("/")},o=function(e){return e.split("/").slice(0,-1).join("/")},a=function(t){return function(r){var n=o(t),a=i(n,r);return e.require(a,t)}},u=function(e,t){var n={id:e,exports:{}};return r[e]=n,t(n.exports,a(e),n),n.exports},c=function(e,o){var a=i(e,".");if(null==o&&(o="/"),n(r,a))return r[a].exports;if(n(t,a))return u(a,t[a]);var c=i(a,"./index");if(n(r,c))return r[c].exports;if(n(t,c))return u(c,t[c]);throw new Error('Cannot find module "'+e+'" from "'+o+'"')},s=function(e,r){if("object"==typeof e)for(var i in e)n(e,i)&&(t[i]=e[i]);else t[e]=r},l=function(){var e=[];for(var r in t)n(t,r)&&e.push(r);return e};e.require=c,e.require.define=s,e.require.register=s,e.require.list=l,e.require.brunch=!0}}(),require.register("overlay/start",function(){function e(e){return decodeURI((RegExp(e+"=(.+?)(&|$)").exec(location.search)||[,null])[1])}var t;t=function(e,t){return setTimeout(t,e)},$(function(){var r,n,i,o,a,u;return $(".overlay-container").addClass("visible"),i=e("id"),$.ajax("/api/products/"+i+"/buy",{async:!1,success:function(e){return window.product=e}}),o=window.product,$("[data-product-cover]").each(function(e,t){return $(t).attr("src",o.image_url)}),$("[data-price-btc]").each(function(e,t){return $(t).html(parseFloat(o.btc.toFixed(6)).toString())}),$("[data-price-usd]").each(function(e,t){return $(t).html(parseFloat(o.price.toFixed(2)).toString())}),$("[data-user-name]").each(function(e,t){return $(t).html(o.user.full_name)}),$("[data-product-title]").each(function(e,t){return $(t).html(o.title)}),$("[data-user-avatar]").each(function(e,t){return $(t).attr("src",o.user.img)}),$("[data-product-description]").each(function(e,t){return $(t).html(o.description)}),$("[data-product-details]").each(function(e,t){var r,n,i,a,u,c;for(i="You'll get ",i+=o.assets.length,1===o.assets.length&&(i+=" "+o.assets[0].asset_file_name.split(".")[1].toUpperCase()+" file"),n=0,c=o.assets,a=0,u=c.length;u>a;a++)r=c[a],n+=r.asset_file_size/1e3;return i+=", "+n.toFixed(0)+" kb total",$(t).html(i)}),t(200,function(){return $(".overlay").addClass("visible")}),u="https://coinbase.com/inline_payments/",r=function(e){return $(".panel-container").eq(e).removeClass("visible"),t(200,function(){return $(".panel-container").eq(e).hide(),$(".panel-container").eq(e+1).show(),$(".panel-container").eq(e+1).addClass("visible"),$("iframe").attr("src",u+o.button_code)}),1===e?($("iframe").remove(),t(100,function(){return $("input").focus()})):void 0},$('a[data-href="buy"]').click(function(){return r(0)}),a=function(e){var t,n;return"https://coinbase.com"===e.origin&&(n=e.data.split("|")[0],t=e.data.split("|")[1],"coinbase_payment_complete"===n)?(console.log("payment complete"),r(1)):void 0},window.addEventListener("message",a,!1),$('a[data-href="submit"]').click(function(){var e;return e=$("input").val(),""===e?void alert("Email address is required to download purchased files!"):$.ajax("/api/products/"+o.id+"/purchase?email="+encodeURIComponent(e),{method:"POST",success:function(){return r(2)()}})}),n="http://www.coinery.io",/local/.test(window.location.href)&&(n="http://localhost:3000"),$('a[data-href="close"]').click(function(){return window.parent.postMessage("close_preview",n)})})});
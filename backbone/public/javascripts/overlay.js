!function(){"use strict";var e="undefined"!=typeof window?window:global;if("function"!=typeof e.require){var t={},r={},n=function(e,t){return{}.hasOwnProperty.call(e,t)},i=function(e,t){var r,n,i=[];r=/^\.\.?(\/|$)/.test(t)?[e,t].join("/").split("/"):t.split("/");for(var a=0,o=r.length;o>a;a++)n=r[a],".."===n?i.pop():"."!==n&&""!==n&&i.push(n);return i.join("/")},a=function(e){return e.split("/").slice(0,-1).join("/")},o=function(t){return function(r){var n=a(t),o=i(n,r);return e.require(o,t)}},s=function(e,t){var n={id:e,exports:{}};return r[e]=n,t(n.exports,o(e),n),n.exports},u=function(e,a){var o=i(e,".");if(null==a&&(a="/"),n(r,o))return r[o].exports;if(n(t,o))return s(o,t[o]);var u=i(o,"./index");if(n(r,u))return r[u].exports;if(n(t,u))return s(u,t[u]);throw new Error('Cannot find module "'+e+'" from "'+a+'"')},c=function(e,r){if("object"==typeof e)for(var i in e)n(e,i)&&(t[i]=e[i]);else t[e]=r},l=function(){var e=[];for(var r in t)n(t,r)&&e.push(r);return e};e.require=u,e.require.define=c,e.require.register=c,e.require.list=l,e.require.brunch=!0}}(),require.register("overlay/start",function(){var e;console.log("this is working"),e=function(e,t){return setTimeout(t,e)},$(function(){var t,r;return t={"[data-price-btc]":"btc","span[data-price-usd]":"price","h1[data-product-title]":"title","span[data-user-name]":"user.full_name","span[data-product-description]":"description"},r={},r.btc=13e-5,r.usd=124.235523,r.user={full_name:"David Oates",img:"http://pbs.twimg.com/profile_images/1419786039/profileimage_normal.gif"},r.title="David's First Product",r.description='As a thank you for pre-ordering "The Blessed Unrest", I want you to have THREE free downloads, and the entirety of the brand new album!!<br>\nI\'m so excited to be sharing the new music, and thank you a million times over for your support.',r.assets=[{asset_file_name:"twitter.png",asset_file_size:235235}],$("[data-price-btc]").each(function(e,t){return $(t).html(parseFloat(r.btc.toFixed(6)).toString())}),$("[data-price-usd]").each(function(e,t){return $(t).html(parseFloat(r.usd.toFixed(2)).toString())}),$("[data-user-name]").each(function(e,t){return $(t).html(r.user.full_name)}),$("[data-product-title]").each(function(e,t){return $(t).html(r.title)}),$("[data-user-avatar]").each(function(e,t){return $(t).attr("src",r.user.img)}),$("[data-product-description]").each(function(e,t){return $(t).html(r.description)}),$("[data-product-details]").each(function(e,t){var n,i,a,o,s,u;for(a="You'll get ",a+=r.assets.length,1===r.assets.length&&(a+=" "+r.assets[0].asset_file_name.split(".")[1].toUpperCase()+" file"),i=0,u=r.assets,o=0,s=u.length;s>o;o++)n=u[o],i+=n.asset_file_size/1e3;return a+=", "+i.toFixed(0)+" kb total",$(t).html(a)}),e(2e3,function(){return $(".panel-container").eq(0).removeClass("visible"),e(200,function(){return $(".panel-container").eq(0).hide(),$(".panel-container").eq(1).show(),$(".panel-container").eq(1).addClass("visible")})})})});
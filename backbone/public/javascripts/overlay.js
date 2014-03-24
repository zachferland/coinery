(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var require = function(name, loaderPath) {
    var path = expand(name, '.');
    if (loaderPath == null) loaderPath = '/';

    if (has(cache, path)) return cache[path].exports;
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex].exports;
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '" from '+ '"' + loaderPath + '"');
  };

  var define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  var list = function() {
    var result = [];
    for (var item in modules) {
      if (has(modules, item)) {
        result.push(item);
      }
    }
    return result;
  };

  globals.require = require;
  globals.require.define = define;
  globals.require.register = define;
  globals.require.list = list;
  globals.require.brunch = true;
})();
require.register("overlay/start", function(exports, require, module) {

function getURLParameter(name) {
  return decodeURI(
    (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
  );
}
;
var delay;

delay = function(ms, func) {
  return setTimeout(func, ms);
};

$(function() {
  var advanceStep, destination, p_id, product, receiveMessage, url_root,
    _this = this;
  $('.overlay-container').addClass('visible');
  window.parent.$('body').addClass('noscroll');
  p_id = getURLParameter('id');
  $.ajax("/api/products/" + p_id + "/buy", {
    async: false,
    success: function(response) {
      return window.product = response;
    }
  });
  product = window.product;
  $('[data-product-cover]').each(function(i, el) {
    return $(el).attr('src', product['image_url']);
  });
  $('[data-price-btc]').each(function(i, el) {
    return $(el).html(parseFloat(product['btc'].toFixed(6)).toString());
  });
  $('[data-price-usd]').each(function(i, el) {
    return $(el).html(parseFloat(product['price'].toFixed(2)).toString());
  });
  $('[data-user-name]').each(function(i, el) {
    return $(el).html(product.user.full_name);
  });
  $('[data-product-title]').each(function(i, el) {
    return $(el).html(product.title);
  });
  $('[data-user-avatar]').each(function(i, el) {
    return $(el).attr('src', product.user.img);
  });
  $('[data-product-description]').each(function(i, el) {
    return $(el).html(product.description);
  });
  $('[data-product-details]').each(function(i, el) {
    var asset, size, string, _i, _len, _ref;
    string = "You'll get ";
    string += product.assets.length;
    if (product.assets.length === 1) {
      string += " " + (product.assets[0].asset_file_name.split(".")[1].toUpperCase()) + " file";
    }
    size = 0;
    _ref = product.assets;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      asset = _ref[_i];
      size += asset.asset_file_size / 1000;
    }
    string += ", " + (size.toFixed(0)) + " kb total";
    return $(el).html(string);
  });
  delay(200, function() {
    return $('.overlay').addClass('visible');
  });
  url_root = "https://coinbase.com/inline_payments/";
  advanceStep = function(current) {
    $('.panel-container').eq(current).removeClass('visible');
    delay(200, function() {
      $('.panel-container').eq(current).hide();
      $('.panel-container').eq(current + 1).show();
      $('.panel-container').eq(current + 1).addClass('visible');
      return $('iframe').attr('src', url_root + product['button_code']);
    });
    if (current === 1) {
      $('iframe').remove();
      return delay(100, function() {
        return $('input').focus();
      });
    }
  };
  $('a[data-href="buy"]').click(function(e) {
    return advanceStep(0);
  });
  receiveMessage = function(event) {
    var event_id, event_type;
    if (event.origin === "https://coinbase.com") {
      event_type = event.data.split("|")[0];
      event_id = event.data.split("|")[1];
      if (event_type === "coinbase_payment_complete") {
        console.log("payment complete");
        return advanceStep(1);
      }
    }
  };
  window.addEventListener("message", receiveMessage, false);
  $('a[data-href="submit"]').click(function(e) {
    var email;
    email = $('input').val();
    if (email === '') {
      alert("Email address is required to download purchased files!");
      return;
    }
    return $.ajax("/api/products/" + product['id'] + "/purchase?email=" + (encodeURIComponent(email)), {
      method: 'POST',
      success: function(response) {
        return advanceStep(2)();
      }
    });
  });
  destination = 'http://www.coinery.io';
  if (/local/.test(window.location.href)) {
    destination = 'http://localhost:3000';
  }
  return $('a[data-href="close"]').click(function(e) {
    window.parent.postMessage('close_preview', destination);
    return window.parent.$('body').removeClass('noscroll');
  });
});
});

;
//# sourceMappingURL=overlay.js.map
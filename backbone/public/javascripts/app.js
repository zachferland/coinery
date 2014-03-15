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
require.register("app", function(exports, require, module) {
var Product, Router, User;

Router = require('router');

User = require('models/user');

Product = require('models/product');

module.exports = {
  start: function() {
    var init, user;
    user = new User({
      validated_session: false
    });
    init = function() {
      var router;
      router = new Router({
        user: user
      });
      return Backbone.history.start();
    };
    return user.fetch({
      async: false,
      success: function(response) {
        user.setValidSession();
        return init();
      },
      error: function(xhr, status, error) {
        return init();
      }
    });
  }
};
});

;require.register("collections/products", function(exports, require, module) {
var Product, Products, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Product = require('models/product');

module.exports = Products = (function(_super) {
  __extends(Products, _super);

  function Products() {
    _ref = Products.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Products.prototype.url = '/api/products';

  Products.prototype.model = Product;

  Products.prototype.initialize = function(options) {};

  return Products;

})(Backbone.Collection);
});

;require.register("init", function(exports, require, module) {
var App;

App = require('app');

window.delay = function(ms, func) {
  return setTimeout(func, ms);
};

window.debug = !(window.location.hostname.indexOf('local') === -1);

console.log("DEBUG: " + window.debug);

window.sexyHash = function() {
  var stripBad;
  stripBad = function(string) {
    var _ref;
    if ((_ref = string.charAt(0)) !== '#' && _ref !== '/') {
      return "/" + string;
    }
    return stripBad(string.slice(1));
  };
  return location.hash = stripBad(location.hash);
};

window.sexyHash();

$(function() {
  $.ajaxSetup({
    type: "POST",
    data: {},
    dataType: 'json',
    crossDomain: true,
    xhrFields: {
      withCredentials: true
    }
  });
  Backbone.$ = jQuery;
  Pace.start();
  return App.start();
});
});

;require.register("models/product", function(exports, require, module) {
var Product, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = Product = (function(_super) {
  __extends(Product, _super);

  function Product() {
    _ref = Product.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Product.prototype.url = function() {
    return '/api/products';
  };

  Product.prototype.urlRoot = function() {
    return '/api/products';
  };

  Product.prototype.defaults = {
    'title': '',
    'description': '',
    'price': "0"
  };

  Product.prototype.initialize = function(options) {};

  Product.prototype.setTitle = function(title) {
    return this.set('title', title);
  };

  Product.prototype.getTitle = function() {
    return this.get('title');
  };

  Product.prototype.setPrice = function(price) {
    return this.set('price', price);
  };

  Product.prototype.getPrice = function() {
    return this.get('price');
  };

  Product.prototype.getDescription = function() {
    return this.get('description');
  };

  Product.prototype.setDescription = function(description) {
    return this.set('description', description);
  };

  Product.prototype.getReadableStatus = function() {
    var status;
    status = this.get('status');
    switch (status) {
      case 0:
        return "???";
      case 1:
        return "Draft";
      case 2:
        return "Draft";
      case 3:
        return "Live";
    }
    return "unkown";
  };

  Product.prototype.setAssets = function(array) {
    return this.set('assets', array);
  };

  Product.prototype.getAssets = function() {
    return this.get('assets');
  };

  Product.prototype.getAssetsFromServer = function() {
    var _this = this;
    return $.ajax("/api/products/" + this.id + "/assets", {
      method: 'GET',
      async: false,
      success: function(response) {
        _this.setAssets(response);
        return _this.trigger('fetched_assets');
      }
    });
  };

  return Product;

})(Backbone.Model);
});

;require.register("models/user", function(exports, require, module) {
var User, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = User = (function(_super) {
  __extends(User, _super);

  function User() {
    _ref = User.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  User.prototype.url = '/api/user';

  User.prototype.initialize = function(options) {};

  User.prototype.getName = function() {
    return this.get('full_name');
  };

  User.prototype.setValidSession = function() {
    return this.set('validated_session', true);
  };

  User.prototype.getValidSession = function() {
    return this.get('validated_session');
  };

  User.prototype.getTwitterHandle = function() {
    return "@" + (this.get('username'));
  };

  return User;

})(Backbone.Model);
});

;require.register("router", function(exports, require, module) {
var AccountView, CustomersView, EditProductView, LoginView, NewProductView, Product, ProductsCollection, ProductsView, Router, SidebarView, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

SidebarView = require('views/nav');

ProductsView = require('views/products');

CustomersView = require('views/customers');

NewProductView = require('views/new');

AccountView = require('views/account');

LoginView = require('views/login');

EditProductView = require('views/edit');

ProductsCollection = require('collections/products');

Product = require('models/product');

module.exports = Router = (function(_super) {
  __extends(Router, _super);

  function Router() {
    _ref = Router.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Router.prototype.routes = function() {
    return {
      'products': 'productsHandler',
      'products/new': 'newProductHandler',
      'products/edit/:id': 'editProductHandler',
      'customers': 'customersHandler',
      'account': 'accountHandler',
      'login': 'loginHandler',
      '*a': 'productsHandler'
    };
  };

  Router.prototype.initialize = function(options) {
    var nav,
      _this = this;
    this.user = options.user;
    this.on('route', window.sexyHash);
    nav = new SidebarView({
      model: this.user
    });
    nav.render();
    this.on('route', function(router, route) {
      return nav.setActive(router.replace('Handler', ''));
    });
    return this.view = null;
  };

  Router.prototype.loginHandler = function() {
    var view;
    if (!this.session()) {
      view = new LoginView({
        model: this.user
      });
      this.loadView(view);
      return;
    }
    return this.productsHandler();
  };

  Router.prototype.editProductHandler = function(id) {
    var view;
    if (this.session()) {
      this.requireConversionRate();
      this.requireProducts();
      view = new EditProductView({
        user: this.user,
        model: this.products.get(id)
      });
      return this.loadView(view);
    }
  };

  Router.prototype.productsHandler = function() {
    var view;
    if (this.session()) {
      this.requireProducts();
      view = new ProductsView({
        user: this.user,
        collection: this.products
      });
      this.loadView(view);
      return;
    }
    return this.requireLogin();
  };

  Router.prototype.customersHandler = function() {
    var customers;
    if (this.session()) {
      customers = new CustomersView({
        model: this.user
      });
      this.loadView(customers);
      return;
    }
    return this.requireLogin();
  };

  Router.prototype.accountHandler = function() {
    var account;
    if (this.session()) {
      account = new AccountView({
        model: this.user
      });
      this.loadView(account);
      return;
    }
    return this.requireLogin();
  };

  Router.prototype.newProductHandler = function() {
    var product, view;
    if (this.session()) {
      this.requireConversionRate();
      this.requireProducts();
      product = new Product;
      view = new NewProductView({
        collection: this.products,
        user: this.user,
        model: product
      });
      this.loadView(view);
      return;
    }
    return this.requireLogin();
  };

  Router.prototype.loadView = function(view) {
    var replace, setVisibility,
      _this = this;
    setVisibility = function(show) {
      if (show) {
        return $('.main-container').addClass('visible');
      } else {
        return $('.main-container').removeClass('visible');
      }
    };
    replace = function() {
      _this.view = view;
      _this.view.render();
      return setVisibility(true);
    };
    if (this.view != null) {
      setVisibility(false);
    }
    if (!this.view) {
      replace();
      setVisibility(true);
      return;
    }
    return delay(210, function() {
      _this.view.undelegateEvents();
      _this.view.$el.html('');
      return replace();
    });
  };

  Router.prototype.session = function() {
    if (this.user.getValidSession()) {
      return true;
    }
    return false;
  };

  Router.prototype.requireLogin = function() {
    return Backbone.history.navigate('login', {
      trigger: true
    });
  };

  Router.prototype.requireProducts = function() {
    if (this.products == null) {
      this.products = new ProductsCollection;
      return this.products.fetch({
        async: false
      });
    }
  };

  Router.prototype.requireConversionRate = function() {
    if (window.conversion_rate == null) {
      return $.ajax("/api/coinbase/price", {
        async: false,
        success: function(response) {
          return window.conversion_rate = response;
        }
      });
    }
  };

  return Router;

})(Backbone.Router);
});

;require.register("templates/account", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "Manage your account here.\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/customers", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "Check our your customers!\n<a href=\"/auth/twitter\">Sign in with Twitta</a>\n\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/dropzone-edit", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-progress\" style=\"display: block\">\n    <span class=\"dz-upload\" data-dz-uploadprogress>\n      <span data-dz-name class=\"filename\"></span>\n    </span>\n  </div>\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name>myfile.png</span></div>\n  </div>\n  <a class=\"delete small\" data-href=\"remove-file\">Delete</a>\n  <span class=\"dz-size\" data-dz-size></span>\n</div>\n\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/dropzone", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-progress\" style=\"display: block\">\n    <span class=\"dz-upload\" data-dz-uploadprogress>\n      <span data-dz-name class=\"filename\"></span>\n    </span>\n  </div>\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name>myfile.png</span></div>\n  </div>\n  <div class=\"dz-success-mark\"><span><i class=\"fa fa-check\"></i></span></div>\n  <div class=\"dz-error-mark\"><span><i class=\"fa fa-exclamation-circle\"></i></span></div>\n  <div class=\"dz-meta\">\n    <span class=\"dz-size\" data-dz-size></span><span class=\"dz-error-msg\" data-dz-errormessage></span>\n  </div>\n  <span class=\"dz-progress-percent\"></span>\n</div>\n\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/edit", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, helper, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<header style=\"width: 600px;\">\n  <h2 class=\"left\"><strong style=\"letter-spacing: -1px;\">";
  if (helper = helpers.title) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.title); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</strong> </h2>\n  <a class=\"button small right\" data-href=\"save\">Save Draft</a>\n  <a class=\"button small gray right\" data-href=\"publish\">Publish</a>\n</header>\n\n<div class=\"overlay-container\">\n</div>\n\n<div class=\"files-container\">\n</div>\n\n";
  return buffer;
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/files", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<header>\n  <h4>Add/Edit Files</h4>\n  <p> Files your customer can download after a successful purchase</p>\n  <a class=\"button small gray right\" data-href=\"trigger-dz\">Add Files</a>\n</header>\n<div class=\"dz-preview-container edit-view\"></div>\n<span class=\"or\" style=\"display: none;\"> or, </span>\n<a data-href=\"dropzone\" class=\"button small\">Upload Files</a>\n\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/login", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<h2><strong>Login with Twitter</strong> to get started.</h2>\n<p><strong>Make money online with no effort.</strong>\n  With Coinery, you can effortlessly sell products with Bitcoin\n  as the payment method. Get started by connecting your Twitter account!\n  We are here to help if you need us.\n</p>\n<br>\n<a class=\"button twitter\" href=\"/auth/twitter\">Login with Twitter <i class=\"fa fa-twitter\"></i></a>\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/nav", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div class=\"logo\"></div>\n<ul>\n  <li><a data-href=\"products\">Products</a></li>\n  <li><a data-href=\"customers\">Customers</a></li>\n  <li><a data-href=\"account\">Account</a></li>\n</ul>\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/new", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<a data-href=\"back\" class=\"back\">\n  <i class=\"fa fa-angle-left\"></i> Back to Products\n</a>\n\n<div class=\"fieldset\">\n  <h4><strong>Enter a name for a product</strong></h4>\n  <div class=\"field\">\n    <input required class=\"wide\" type=\"text\" placeholder=\"What are you selling?\">\n    <a class=\"button attached\" data-href=\"save\">Save</a>\n  </div>\n  <span class=\"hint\"><em>ie. My Special Ebook, David's Debut Album</em></span>\n</div>\n\n<div class=\"fieldset hidden\">\n  <h4><strong>How much does it cost?</strong></h4>\n  <div class=\"field\">\n    <div class=\"field-wrapper\" data-currency=\"USD\">\n      <input required class=\"currency\" type=\"text\" placeholder=\"$0\">\n    </div>\n    <div class=\"field-wrapper\" data-currency=\"BTC\">\n      <input required class=\"currency\" type=\"text\" placeholder=\"0.00\">\n    </div>\n    <a class=\"button\" data-href=\"save\">Save</a>\n  </div>\n</div>\n\n<div class=\"fieldset hidden\">\n  <h4><strong>Last step! Upload a file for your product</strong></h4>\n  <p class=\"hint\">The customer will receive these files after a successful purchase.<p>\n  <div class=\"dz-preview-container\"></div>\n  <a data-href=\"done\" class=\"button\" style=\"display: none;\">I'm Done!</a>\n  <span class=\"or\" style=\"display: none;\"> or, </span>\n  <a data-href=\"dropzone\" class=\"button\">Upload Files</a>\n</div>\n\n";
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/overlay", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, helper, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1, helper;
  buffer += "\n      <span class=\"status\">";
  if (helper = helpers.status) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.status); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</span>\n    ";
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = "", stack1, helper;
  buffer += "\n        ";
  if (helper = helpers.description) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.description); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "\n      ";
  return buffer;
  }

function program5(depth0,data) {
  
  
  return "\n        Add a description of your product...\n      ";
  }

  buffer += "<div class=\"overlay\">\n  <div class=\"flag\">\n    ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.status), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    <img src=\"images/flag.svg\" width=\"81\" height=\"81\">\n  </div>\n  <div class=\"cover\">\n    <div class=\"cover-container\">\n      <img class=\"cam\" src=\"images/camera.svg\"><br>\n      <a class=\"button dark\" data-href=\"cover-dropzone\">Upload Cover Photo<i class=\"fa fa-cloud-upload\"></i></a>\n      <div style=\"display: none;\" class=\"dz-cover-preview-container\"></div>\n    </div>\n  </div>\n  <div class=\"product-main\">\n    <div class=\"field-container\">\n      <div class=\"title-container\">\n        <input class=\"title\" data-id=\"title\" value=\"";
  if (helper = helpers.title) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.title); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "\">\n      </div>\n      <div class=\"price-container\">\n        <div class=\"field-wrapper\" data-currency=\"BTC\">\n          <input class=\"btc\" type=\"text\">\n        </div>\n        <div class=\"field-wrapper\" data-currency=\"USD\">\n          <input class=\"usd\" type=\"text\">\n        </div>\n      </div>\n    </div>\n    <div class=\"description\" contenteditable>\n      ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.description), {hash:{},inverse:self.program(5, program5, data),fn:self.program(3, program3, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </div>\n  </div>\n</div>\n\n";
  return buffer;
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("templates/products", function(exports, require, module) {
var __templateData = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n  <header>\n    <h2 class=\"left\">My Products</h2>\n    <a data-href=\"new-product\" class=\"button small right\">New Product</a>\n  </header>\n  <ul class=\"products-list\">\n    ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.products), {hash:{},inverse:self.noop,fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    <li class=\"new\">\n      <a class=\"cover\" data-href=\"new-product\">\n        <div class=\"product-cover\">\n          <svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.1\" id=\"Layer_1\" x=\"0px\" y=\"0px\" width=\"42px\" height=\"42px\" viewBox=\"0 0 100 100\" style=\"enable-background:new 0 0 100 100;\" xml:space=\"preserve\">\n          <polygon style=\"fill:#010101;\" points=\"100,37.5 62.5,37.5 62.5,0 37.5,0 37.5,37.5 0,37.5 0,62.5 37.5,62.5 37.5,100 62.5,100   62.5,62.5 100,62.5 \"/>\n          </svg>\n        </div>\n      </a>\n      <div class=\"product-meta\">\n        <div class=\"title-container\">\n          <h3 style=\"visibility: hidden;\">New</h3>\n        </div>\n        <span class=\"status\" style=\"visibility: hidden;\">\n          Published\n        </span>\n      </div>\n    </li>\n</ul>\n";
  return buffer;
  }
function program2(depth0,data) {
  
  var buffer = "", stack1, helper;
  buffer += "\n      <li class=\"product-container\" data-product-id=\"";
  if (helper = helpers.id) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.id); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "\">\n        <a class=\"cover\" data-href=\"edit-product\">\n          <div class=\"product-cover\">\n            <div class=\"price-container\">\n              <h4>";
  if (helper = helpers.price) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.price); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</h4>\n            </div>\n            ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.product)),stack1 == null || stack1 === false ? stack1 : stack1.image), {hash:{},inverse:self.program(5, program5, data),fn:self.program(3, program3, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n          </div>\n        </a>\n        <div class=\"product-meta\">\n          <div class=\"dropdown\">\n            <a class=\"dropdown-toggle\">\n              <i class=\"fa fa-cog\"></i>\n              <i class=\"fa fa-chevron-down\"></i>\n            </a>\n            <ul class=\"dropdown-menu\" role=\"menu\" aria-labelledby=\"dLabel\">\n              <li>\n                <a data-href=\"edit-product\">\n                  Edit Product\n                </a>\n              </li>\n              <li>\n                <a data-href=\"delete\">\n                  Delete\n                </a>\n              </li>\n            </ul>\n          </div>\n          <div class=\"title-container\">\n            <h3>";
  if (helper = helpers.title) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.title); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  buffer += escapeExpression(stack1)
    + "</h3>\n          </div>\n          <span class=\"status\">\n            Published\n          </span>\n        </div>\n      </li>\n    ";
  return buffer;
  }
function program3(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n              <img src=\""
    + escapeExpression(((stack1 = ((stack1 = ((stack1 = (depth0 && depth0.product)),stack1 == null || stack1 === false ? stack1 : stack1.image)),stack1 == null || stack1 === false ? stack1 : stack1.url)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">\n            ";
  return buffer;
  }

function program5(depth0,data) {
  
  
  return "\n              <svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.1\" id=\"Layer_1\" x=\"0px\" y=\"0px\" width=\"70px\" height=\"70px\" viewBox=\"0 0 32 32\" enable-background=\"new 0 0 32 32\" xml:space=\"preserve\">\n                <path id=\"package\" d=\"M17.578,22.504l-1.758-4.129l-2.007,4.752l-7.519-3.289l0.174,3.905l9.437,4.374l10.91-5.365l-0.146-4.988  L17.578,22.504z M29.954,7.119L19.021,3.883l-3.006,2.671l-3.091-2.359L2.046,8.699l3.795,3.048l-3.433,5.302l10.879,4.758  l2.53-5.999l2.257,5.308l11.393-5.942l-3.105-4.709L29.954,7.119z M15.777,15.079l-9.059-3.83l9.275-4.101l9.608,3.255  L15.777,15.079z\"/>\n              </svg>\n            ";
  }

function program7(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n  <div class=\"prompt\"></div>\n  <a data-href=\"products/new\" class=\"button create-button\">Create a Product<span class=\"plus\">+</span></a>\n  <h2>\n    <strong>\n      Hey ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.username), {hash:{},inverse:self.noop,fn:self.program(8, program8, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "!\n    </strong>\n    Welcome to Coinery\n  </h2>\n  <p>\n    Thanks for trying out Coinery.\n    With Coinery, you can <strong>effortlessly sell products with Bitcoin\n    as the payment method.</strong> Get started by creating your first\n    product! We are here to help if you need us.\n  </p>\n  <p>\n    - The Coinery Team\n  </p>\n\n";
  return buffer;
  }
function program8(depth0,data) {
  
  var stack1, helper;
  if (helper = helpers.username) { stack1 = helper.call(depth0, {hash:{},data:data}); }
  else { helper = (depth0 && depth0.username); stack1 = typeof helper === functionType ? helper.call(depth0, {hash:{},data:data}) : helper; }
  return escapeExpression(stack1);
  }

  stack1 = helpers['if'].call(depth0, (depth0 && depth0.products), {hash:{},inverse:self.program(7, program7, data),fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n\n\n\n\n";
  return buffer;
  });
if (typeof define === 'function' && define.amd) {
  define([], function() {
    return __templateData;
  });
} else if (typeof module === 'object' && module && module.exports) {
  module.exports = __templateData;
} else {
  __templateData;
}
});

;require.register("views/account", function(exports, require, module) {
var AccountView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/account');

module.exports = AccountView = (function(_super) {
  __extends(AccountView, _super);

  function AccountView() {
    _ref = AccountView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  AccountView.prototype.el = '.content';

  AccountView.prototype.events = function() {};

  AccountView.prototype.initialize = function() {
    return this.user = this.model;
  };

  AccountView.prototype.render = function() {
    var ctx;
    ctx = {};
    return this.$el.html(Template(ctx));
  };

  return AccountView;

})(Backbone.View);
});

;require.register("views/customers", function(exports, require, module) {
var CustomersView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/customers');

module.exports = CustomersView = (function(_super) {
  __extends(CustomersView, _super);

  function CustomersView() {
    _ref = CustomersView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  CustomersView.prototype.el = '.content';

  CustomersView.prototype.events = function() {
    return {
      'click a': 'linkHandler'
    };
  };

  CustomersView.prototype.initialize = function() {
    return this.user = this.model;
  };

  CustomersView.prototype.render = function() {
    var ctx;
    ctx = {};
    return this.$el.html(Template(ctx));
  };

  CustomersView.prototype.linkHandler = function(e) {
    var dest;
    e.preventDefault();
    dest = $(e.target).attr('data-href');
    return Backbone.history.navigate(dest);
  };

  return CustomersView;

})(Backbone.View);
});

;require.register("views/edit", function(exports, require, module) {
var EditProductView, FilesView, OverlayView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

OverlayView = require('views/overlay');

FilesView = require('views/files');

Template = require('templates/edit');

module.exports = EditProductView = (function(_super) {
  __extends(EditProductView, _super);

  function EditProductView() {
    _ref = EditProductView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  EditProductView.prototype.el = '.content';

  EditProductView.prototype.events = function() {
    return {
      'click a[data-href="save"]': 'saveHandler',
      'click a[data-href="publish"]': 'publishHandler'
    };
  };

  EditProductView.prototype.initialize = function(options) {
    return this.user = options.user;
  };

  EditProductView.prototype.render = function() {
    var ctx;
    ctx = {
      'title': this.model.getTitle()
    };
    this.$el.html(Template(ctx));
    this.renderOverlay();
    return this.renderFiles();
  };

  EditProductView.prototype.publishHandler = function(e) {
    e.preventDefault();
    console.log('handler called');
    return this.model.save("/api/products/" + (this.model.get('id')) + "/publish", {
      success: function(response) {
        return console.log('hey');
      }
    });
  };

  EditProductView.prototype.renderOverlay = function() {
    var overlay;
    overlay = new OverlayView({
      user: this.user,
      model: this.model
    });
    return overlay.render();
  };

  EditProductView.prototype.renderFiles = function() {
    var files;
    files = new FilesView({
      user: this.user,
      model: this.model
    });
    return files.render();
  };

  return EditProductView;

})(Backbone.View);
});

;require.register("views/files", function(exports, require, module) {
var DropzoneTemplate, FilesView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/files');

DropzoneTemplate = require('templates/dropzone-edit');

module.exports = FilesView = (function(_super) {
  __extends(FilesView, _super);

  function FilesView() {
    _ref = FilesView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  FilesView.prototype.el = '.files-container';

  FilesView.prototype.events = function() {
    return {
      'click a[data-href="remove-file"]': 'fileDeleteHandler',
      'click a[data-href="trigger-dz"]': 'triggerDropzoneHandler'
    };
  };

  FilesView.prototype.initialize = function(options) {
    this.user = options.user;
    return this.model.getAssetsFromServer();
  };

  FilesView.prototype.render = function() {
    this.$el.html(Template({}));
    return this.dropzoneInit();
  };

  FilesView.prototype.triggerDropzoneHandler = function(e) {
    e.preventDefault();
    console.log('trying this');
    return window.jQuery('a[data-href="dropzone"]')[0].click();
  };

  FilesView.prototype.dropzoneInit = function() {
    var asset, dropzone, file, filesize, setIDs, url, _i, _len, _ref1,
      _this = this;
    filesize = function(size) {
      var string;
      if (size >= Math.pow(1024, 4) / 10) {
        size = size / (Math.pow(1024, 4) / 10);
        string = "TB";
      } else if (size >= Math.pow(1024, 3) / 10) {
        size = size / (Math.pow(1024, 3) / 10);
        string = "GB";
      } else if (size >= Math.pow(1024, 2) / 10) {
        size = size / (Math.pow(1024, 2) / 10);
        string = "MB";
      } else if (size >= 1024 / 10) {
        size = size / (1024 / 10);
        string = "KB";
      } else {
        size = size * 10;
        string = "b";
      }
      return "<strong>" + (Math.round(size) / 10) + "</strong>" + string;
    };
    Dropzone.prototype.filesize = filesize;
    dropzone = new Dropzone('a[data-href="dropzone"]', {
      paramName: 'asset',
      previewsContainer: '.dz-preview-container',
      previewTemplate: DropzoneTemplate({}),
      url: "#"
    });
    url = function() {
      return "/api/products/" + (_this.model.get('id')) + "/assets";
    };
    dropzone.options.url = url();
    _ref1 = this.model.getAssets();
    for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
      asset = _ref1[_i];
      file = {};
      file['name'] = asset.asset_file_name;
      file['size'] = asset.asset_file_size;
      file['id'] = asset.id;
      dropzone.emit("addedfile", file);
      dropzone.emit("success", file);
      dropzone.files.push(file);
    }
    setIDs = function() {
      var _j, _len1, _ref2, _results;
      _ref2 = dropzone.files;
      _results = [];
      for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
        file = _ref2[_j];
        _results.push(file.previewElement.setAttribute("data-file-id", file.id));
      }
      return _results;
    };
    setIDs();
    return dropzone.on('success', function(file, response) {
      file.id = response['id'];
      return setIDs();
    });
  };

  FilesView.prototype.fileDeleteHandler = function(e) {
    var $el, id,
      _this = this;
    $el = $(e.target).closest('.dz-preview');
    id = $el.attr('data-file-id');
    return $.ajax("/api/assets/" + id, {
      type: "DELETE",
      success: function(response) {
        _this.model.getAssetsFromServer();
        return _this.render();
      }
    });
  };

  FilesView.prototype.backHandler = function() {
    return Backbone.history.navigate("products", {
      trigger: true
    });
  };

  return FilesView;

})(Backbone.View);
});

;require.register("views/login", function(exports, require, module) {
var LoginView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/login');

module.exports = LoginView = (function(_super) {
  __extends(LoginView, _super);

  function LoginView() {
    _ref = LoginView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  LoginView.prototype.el = '.content';

  LoginView.prototype.events = function() {};

  LoginView.prototype.initialize = function() {
    return this.user = this.model;
  };

  LoginView.prototype.render = function() {
    return this.$el.html(Template({}));
  };

  return LoginView;

})(Backbone.View);
});

;require.register("views/nav", function(exports, require, module) {
var Header, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/nav');

module.exports = Header = (function(_super) {
  __extends(Header, _super);

  function Header() {
    _ref = Header.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Header.prototype.el = '.nav-container';

  Header.prototype.events = function() {
    return {
      'click a': 'navHandler'
    };
  };

  Header.prototype.initialize = function() {
    return this.user = this.model;
  };

  Header.prototype.render = function() {
    var ctx;
    ctx = {};
    return this.$el.html(Template(ctx));
  };

  Header.prototype.navHandler = function(e) {
    var dest;
    e.preventDefault();
    dest = $(e.target).attr('data-href');
    return Backbone.history.navigate(dest, {
      trigger: true
    });
  };

  Header.prototype.setActive = function(route) {
    this.$('li').removeClass('current');
    return $("a[data-href=" + route + "]").parent().addClass('current');
  };

  return Header;

})(Backbone.View);
});

;require.register("views/new", function(exports, require, module) {
var DropzoneTemplate, NewProductView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/new');

DropzoneTemplate = require('templates/dropzone');

module.exports = NewProductView = (function(_super) {
  __extends(NewProductView, _super);

  function NewProductView() {
    _ref = NewProductView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  NewProductView.prototype.el = '.content';

  NewProductView.prototype.events = function() {
    return {
      'click a[data-href="back"]': 'backHandler',
      'click a[data-href="save"]': 'saveHandler',
      'click a[data-href="done"]': 'doneHandler',
      'keyup input.currency': 'currencyHandler',
      'keydown input.currency': 'currencyValidateHandler',
      'focus input': 'inputFocusHandler'
    };
  };

  NewProductView.prototype.initialize = function(options) {
    return this.user = options.user;
  };

  NewProductView.prototype.render = function() {
    this.$el.html(Template({}));
    return this.postRender();
  };

  NewProductView.prototype.postRender = function() {
    return this.$('input').focus();
  };

  NewProductView.prototype.saveHandler = function(e) {
    var $currentStep, errors, step, val, _ref1,
      _this = this;
    e.preventDefault();
    $currentStep = $(e.target).closest('.fieldset');
    step = $currentStep.index();
    errors = 0;
    $currentStep.find('[required]').each(function(i, el) {
      $(el).removeClass('error');
      if ($(el).val() === '') {
        $(el).addClass('error');
        return errors++;
      }
    });
    if (!(errors > 0)) {
      val = $currentStep.find('input').first().val();
      switch (step) {
        case 1:
          this.model.setTitle(val);
          break;
        case 2:
          this.model.setPrice(val.replace('$', ''));
          this.model.save({}, {
            async: false,
            success: function(response) {
              return _this.dropzoneInit();
            },
            error: function(xhr, status) {
              return console.log(xhr, status);
            }
          });
      }
      if ((_ref1 = $currentStep.addClass('complete').next().removeClass('hidden').find('input')) != null) {
        _ref1.first().focus();
      }
    }
    return false;
  };

  NewProductView.prototype.inputFocusHandler = function(e) {
    return $(e.target).closest('.fieldset').removeClass('complete');
  };

  NewProductView.prototype.currencyHandler = function(e) {
    var amount, btc, focus, inputs, rate, raw, usd;
    if (e.keyCode === 190) {
      return;
    }
    inputs = {
      'btc': $('[data-currency="BTC"] input'),
      'usd': $('[data-currency="USD"] input')
    };
    focus = $(e.target).parent().attr('data-currency');
    rate = window.conversion_rate;
    raw = $(e.target).val().replace('$', '');
    amount = parseFloat(raw);
    if (focus === 'BTC') {
      usd = amount / rate;
      if (!isNaN(usd)) {
        inputs.usd.addClass('changing');
        delay(150, function() {
          return inputs.usd.val("$" + (usd.toString()));
        });
        delay(300, function() {
          return inputs.usd.removeClass('changing');
        });
      }
    }
    if (focus === 'USD') {
      btc = amount * rate;
      if (!isNaN(btc)) {
        inputs.btc.addClass('changing');
        delay(150, function() {
          return inputs.btc.val(btc.toFixed(5));
        });
        delay(300, function() {
          return inputs.btc.removeClass('changing');
        });
      }
      if (!isNaN(amount)) {
        return inputs.usd.val("$" + (amount.toString()));
      }
    }
  };

  NewProductView.prototype.dropzoneInit = function() {
    var filesize, uploadprogress, url,
      _this = this;
    uploadprogress = function(file, progress, bytesSent) {
      var i, node, ref, results, width;
      ref = file.previewElement.querySelectorAll("[data-dz-uploadprogress]");
      width = "" + (100 - parseInt(progress)) + "%";
      results = [];
      i = 0;
      while (i < ref.length) {
        node = ref[i];
        results.push(node.style.width = width);
        i++;
      }
      return results;
    };
    filesize = function(size) {
      var string;
      if (size >= Math.pow(1024, 4) / 10) {
        size = size / (Math.pow(1024, 4) / 10);
        string = "TB";
      } else if (size >= Math.pow(1024, 3) / 10) {
        size = size / (Math.pow(1024, 3) / 10);
        string = "GB";
      } else if (size >= Math.pow(1024, 2) / 10) {
        size = size / (Math.pow(1024, 2) / 10);
        string = "MB";
      } else if (size >= 1024 / 10) {
        size = size / (1024 / 10);
        string = "KB";
      } else {
        size = size * 10;
        string = "b";
      }
      return "<strong>" + (Math.round(size) / 10) + "</strong>" + string;
    };
    Dropzone.prototype.defaultOptions.uploadprogress = uploadprogress;
    Dropzone.prototype.filesize = filesize;
    this.dropzone = new Dropzone('a[data-href="dropzone"]', {
      paramName: 'asset',
      previewsContainer: '.dz-preview-container',
      previewTemplate: DropzoneTemplate({}),
      url: "#"
    });
    url = function() {
      return "/api/products/" + (_this.model.get('id')) + "/assets";
    };
    this.dropzone.options.url = url();
    this.dropzone.on('uploadprogress', function(file, progress, bytesSent) {
      return $('.dz-progress-percent').text(Math.round(progress) + "%");
    });
    this.dropzone.on('addedFile', function(file) {
      return console.log(file);
    });
    return this.dropzone.on('success', function(file) {
      return _this.updateFileCTA();
    });
  };

  NewProductView.prototype.updateFileCTA = function() {
    this.$('a[data-href="dropzone"]').removeClass('button').html('Upload Another File');
    this.$('span.or').fadeIn();
    return this.$('a[data-href="done"]').fadeIn();
  };

  NewProductView.prototype.doneHandler = function(e) {
    var _this = this;
    e.preventDefault();
    this.collection.add(this.model);
    return this.model.save({
      'status': 1
    }, {
      url: "/api/products/" + this.model.id,
      success: function() {
        Backbone.history.navigate("products/edit/" + _this.model.id, {
          trigger: true
        });
        return console.log(_this.model);
      }
    });
  };

  NewProductView.prototype.backHandler = function() {
    return Backbone.history.navigate("products", {
      trigger: true
    });
  };

  return NewProductView;

})(Backbone.View);
});

;require.register("views/overlay", function(exports, require, module) {
var OverlayView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/overlay');

module.exports = OverlayView = (function(_super) {
  __extends(OverlayView, _super);

  function OverlayView() {
    _ref = OverlayView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  OverlayView.prototype.el = '.overlay-container';

  OverlayView.prototype.events = function() {
    return {
      'focus input': 'inputFocusHandler',
      'blur input': 'resetFocus',
      'click [contenteditable]': 'contentEditableFocus',
      'keyup .field-wrapper input': 'currencyHandler',
      'keydown .field-wrapper input': 'currencyValidateHandler'
    };
  };

  OverlayView.prototype.initialize = function(options) {
    return this.user = options.user;
  };

  OverlayView.prototype.render = function() {
    var ctx;
    ctx = {
      'id': this.model.id,
      'title': this.model.getTitle(),
      'description': this.model.getDescription(),
      'price': this.model.getPrice(),
      'user_name': this.user.getName(),
      'status': this.model.getReadableStatus()
    };
    this.$el.html(Template(ctx));
    return this.postRender();
  };

  OverlayView.prototype.postRender = function() {
    this.dropzoneInit();
    return this.fillPrice();
  };

  OverlayView.prototype.fillPrice = function() {
    var price, rate;
    rate = 610;
    price = this.model.getPrice();
    $('[data-currency="BTC"] input').val("" + (parseFloat(price) * rate));
    return $('[data-currency="USD"] input').val("$" + (parseFloat(price)));
  };

  OverlayView.prototype.resetFocus = function() {
    this.$('.price-container').removeClass('usd-focus btc-focus focus');
    this.$('.field-container').removeClass('editing-price');
    this.$('.title-container').removeClass('focus');
    return this.$('.description').removeClass('focus');
  };

  OverlayView.prototype.contentEditableFocus = function(e) {
    return $(e.target).addClass('focus');
  };

  OverlayView.prototype.inputFocusHandler = function(e) {
    var _ref1;
    this.resetFocus();
    if ((_ref1 = e.target.className) === 'usd' || _ref1 === 'btc') {
      this.$('.price-container').addClass("" + e.target.className + "-focus focus");
      return this.$('.field-container').addClass('editing-price');
    } else {
      return this.$('.title-container').addClass("focus");
    }
  };

  OverlayView.prototype.currencyHandler = function(e) {
    var amount, btc, focus, inputs, rate, raw, usd;
    if (e.keyCode === 190) {
      return;
    }
    inputs = {
      'btc': $('[data-currency="BTC"] input'),
      'usd': $('[data-currency="USD"] input')
    };
    focus = $(e.target).parent().attr('data-currency');
    rate = 640;
    raw = $(e.target).val().replace('$', '');
    amount = parseFloat(raw);
    if (focus === 'BTC') {
      usd = amount * 640;
      if (!isNaN(usd)) {
        inputs.usd.addClass('changing');
        console.log('changing');
        delay(150, function() {
          return inputs.usd.val("$" + (usd.toString()));
        });
        delay(300, function() {
          return inputs.usd.removeClass('changing');
        });
      }
    }
    if (focus === 'USD') {
      btc = amount / 640;
      if (!isNaN(btc)) {
        inputs.btc.addClass('changing');
        delay(150, function() {
          return inputs.btc.val(btc.toFixed(5));
        });
        delay(300, function() {
          return inputs.btc.removeClass('changing');
        });
      }
      if (!isNaN(amount)) {
        return inputs.usd.val("$" + (amount.toString()));
      }
    }
  };

  OverlayView.prototype.dropzoneInit = function() {
    var dropzone;
    dropzone = new Dropzone('a[data-href="cover-dropzone"]', {
      previewsContainer: '.dz-cover-preview-container',
      url: '#'
    });
    dropzone.on('uploadprogress', function(file, progress, bytesSent) {
      return $('.dz-progress-percent').text(Math.round(progress) + "%");
    });
    return dropzone.on('addedFile', function(file) {
      return console.log(file);
    });
  };

  OverlayView.prototype.backHandler = function() {
    return Backbone.history.navigate("products", {
      trigger: true
    });
  };

  return OverlayView;

})(Backbone.View);
});

;require.register("views/products", function(exports, require, module) {
var ProductsView, Template, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Template = require('templates/products');

module.exports = ProductsView = (function(_super) {
  __extends(ProductsView, _super);

  function ProductsView() {
    _ref = ProductsView.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  ProductsView.prototype.el = '.content';

  ProductsView.prototype.events = function() {
    return {
      'click a': 'linkHandler',
      'click a[data-href="delete"]': 'deleteHandler',
      'click a[data-href="edit-product"]': 'editHandler',
      'click a[data-href="new-product"]': 'newHandler'
    };
  };

  ProductsView.prototype.initialize = function(options) {
    return this.user = options.user;
  };

  ProductsView.prototype.render = function() {
    var ctx, model, product, _i, _len, _ref1;
    ctx = {
      'username': this.user.getTwitterHandle(),
      'products': []
    };
    _ref1 = this.collection.models;
    for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
      model = _ref1[_i];
      product = {};
      product.id = model.id;
      product.title = model.getTitle();
      product.price = model.getPrice();
      ctx['products'].push(product);
    }
    this.$el.html(Template(ctx));
    return this.postRender();
  };

  ProductsView.prototype.postRender = function() {
    return this.$('ul.products-list li').each(function(i, el) {
      console.log('yes');
      return $(el).find('.dropdown-toggle').dropdown();
    });
  };

  ProductsView.prototype.deleteHandler = function(e) {
    var $el, id, model,
      _this = this;
    e.preventDefault();
    $el = $(e.target).closest('li.product-container');
    id = $el.attr('data-product-id');
    model = this.collection.get(id);
    return model.destroy({
      url: "/api/products/" + id,
      success: function(response) {
        _this.collection.remove(model);
        return $el.fadeOut();
      }
    });
  };

  ProductsView.prototype.newHandler = function(e) {
    return Backbone.history.navigate("products/new", {
      trigger: true
    });
  };

  ProductsView.prototype.editHandler = function(e) {
    var id;
    e.preventDefault();
    id = $(e.target).closest('li.product-container').attr('data-product-id');
    return Backbone.history.navigate("products/edit/" + id, {
      trigger: true
    });
  };

  ProductsView.prototype.linkHandler = function(e) {
    var dest;
    e.preventDefault();
    dest = $(e.target).attr('data-href');
    return Backbone.history.navigate(dest, {
      trigger: true
    });
  };

  return ProductsView;

})(Backbone.View);
});

;
//# sourceMappingURL=app.js.map
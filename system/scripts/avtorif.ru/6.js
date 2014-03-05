// Generated by CoffeeScript 1.6.3
(function() {
  var Crawler, async, crawler, fs, util, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  fs = require('fs');

  util = require('util');

  async = require('async');

  _ = require('underscore');

  Crawler = (function() {
    function Crawler(conf) {
      this.start = __bind(this.start, this);
      var _this = this;
      this.urls = [];
      this.queue = async.queue(function(task, callback) {
        var page;
        page = require('webpage').create({
          resourceTimeout: 5000
        });
        page.open(conf.host + task.url, function(status) {
          if (status === 'success') {
            return conf.success(page, task.url, status, function() {
              var url, urls, _i, _len;
              urls = page.evaluate(function() {
                return Array.prototype.slice.call(document.querySelectorAll("a"), 0).map(function(link) {
                  return link.getAttribute("href");
                });
              });
              for (_i = 0, _len = urls.length; _i < _len; _i++) {
                url = urls[_i];
                if (__indexOf.call(_this.urls, url) < 0) {
                  _this.urls.push(url);
                  _this.start(url);
                }
              }
              page.close();
              return callback();
            });
          } else {
            return conf.failure(page, task.url, status, function() {
              page.close();
              return callback();
            });
          }
        });
        return null;
      }, 5);
    }

    Crawler.prototype.start = function(url, callback) {
      return this.queue.push({
        url: url
      }, function(err) {});
    };

    Crawler.prototype.crawl = function(args) {};

    return Crawler;

  })();

  crawler = new Crawler({
    host: "http://www.avtorif.ru",
    success: function(page, url, status, callback) {
      var aaa, data, server;
      if (status === 'success') {
        aaa = require('webpage').create();
        server = 'http://localhost:3002/admin/pages';
        data = "page[path]=" + url + "&page[content]=" + encodeURIComponent(page.content);
        aaa.open(server, "post", data, function(status) {
          return null;
        });
      } else {
        null;
      }
      return callback(null, page, url, status);
    },
    failure: function(page, url, status, callback) {
      return callback(null, page, url, status);
    }
  });

  crawler.start('/', function() {
    return phantom.exit();
  });

}).call(this);
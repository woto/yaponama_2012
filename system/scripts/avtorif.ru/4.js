var async = require('async'),
links = [
    "http://google.com",
    "http://yahoo.com",
    "http://duckduckgo.com",
    "http://bing.com",
];
 
function crawler(url, callback) {
    var page = require('webpage').create();
    page.open(url, function (status) {
        console.log( page.evaluate(function(){ return document.title }) );
        page.close();
        callback.apply();
    });
}
 
async.each(links, crawler, function (err) {
    if (err) console.log(err);
    phantom.exit();
});

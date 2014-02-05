async = require('async');
_ = require('underscore');

// create a cargo object with payload 2

var cargo = async.cargo(function (tasks, callback) {
    console.log(tasks.length);
    for(var i=0; i<tasks.length; i++){
      console.log('hello ' + tasks[i].name);
    }
    callback();
}, 2);


// add some items

cargo.push({name: 'foo'}, function (err) {
    console.log('finished processing foo');


    cargo.push({name: 'aaa'}, function (err) {
      console.log('now!');
      var log = _.bind(console.log, console);
      _.delay(log, 1000, 'logged later');
      console.log('now!');
    });

});
cargo.push({name: 'bar'}, function (err) {
    console.log('finished processing bar');
});
cargo.push({name: 'baz'}, function (err) {
    console.log('finished processing baz');
});
cargo.push({name: 'baz'}, function (err) {
    console.log('finished processing baz');
});
cargo.push({name: 'baz'}, function (err) {
    console.log('finished processing baz');
});
cargo.push({name: 'baz'}, function (err) {
    console.log('finished processing baz');
});
cargo.push({name: 'baz'}, function (err) {
    console.log('finished processing baz');
});
cargo.push({name: 'baz'}, function (err) {
    console.log('finished processing baz');
});

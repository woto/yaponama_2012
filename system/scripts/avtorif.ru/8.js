async = require('async');
_ = require('underscore');

// create a queue object with concurrency 2

var q = async.queue(function (task, callback) {
    console.log('hello ' + task.name);
    callback();
}, 2);


// assign a callback
q.drain = function() {
    console.log('all items have been processed');
    setTimeout(function(){
      q.push({name: 'foo'}, function (err) {
          console.log('finished processing foo');
      });
    })

}

// add some items to the queue

q.push({name: 'foo'}, function (err) {
    console.log('finished processing foo');
});
q.push({name: 'bar'}, function (err) {
    console.log('finished processing bar');
});

// add some items to the queue (batch-wise)

q.push([{name: 'baz'},{name: 'bay'},{name: 'bax'}], function (err) {
    console.log('finished processing bar');
});

// add some items to the front of the queue

q.unshift({name: 'bar'}, function (err) {
    console.log('finished processing bar');
});

var express = require('express');
var app = express();

// set view engine to ejs
app.set('view engine','ejs');

//public folder to store assets
app.use(express.static(__dirname + '/public'));

//routes for app
app.get('/',function(req,res){
    res.render('pad');
});
app.get('/(:id)',function(req,res){
    res.render('pad');
});

//sharejs dependencies
var sharejs = require('share');
var redis = require('redis');
redis.createClient();

//options for sharejs
var options = {
    db:{type: 'redis'}
};

//attach express server to sharejs
sharejs.server.attach(app,options);

//listen on localhost port 8000 or port defined for heroku
var port = process.env.PORT || 8000;

app.listen(port);
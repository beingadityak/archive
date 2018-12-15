var express = require('express');
var app = express();

app.all('/',function(req,res){
    res.send("Hello World !");
});

app.all('/index',function(req,res){
    res.send("Hello , Index !");
});

app.get('/users/:user',function(req,res){
    if(req.params.user != null)
    {
        res.send("You are Searching for user : "+req.params.user);
    }
    else
    {
        res.send("No user found !");
    }
}).post('/users/:user',function(req,res){
    if(req.params.user != null)
    {
        res.send("Welcome,  user : "+req.params.user);
    }
    else
    {
        res.send("No user found !");
    }
});

app.all('/flights/:from-:to',function(req,res){
    res.send("Searching for Flights From "+req.params.from+" To "+req.params.to);
});

var server = app.listen(3000,function()
{
    var host = server.address().address;
    var port = server.address().port;
    console.log("Server Active AT PORT : "+port);
});
var express = require('express');
var socket = require('socket.io');
var app = express();
var http = require('http').createServer(app);
var io = require('socket.io')(http);

var port = process.env.PORT || 8888;

app.get('/',function(req,res){

    res.sendFile(__dirname + '/index.html');

});

io.on('connection',function(socket){
    console.log('user connected');
    socket.on('chat message',function(msg){
        io.emit('chat message',msg);
    });
});


http.listen(port,function(){
    console.log('App running on : '+port);
});

console.log('App on Port : '+port);
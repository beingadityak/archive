var express = require('express');
var bodyParser = require('body-parser');
var request = require('request');

var app = express();
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

// index
app.get('/',function(req,res){
  res.send('Hello World ! I am the backend point of the Rajinikanth Joke Bot ... :D');
});

// fb verify
app.get('/webhook/',function(req,res){
  if(req.query['hub.verify_token'] === 'rajini_bot_the_incredible'){
    res.send(req.query['hub.challenge']);
  }
});

app.post('/webhook/',function(req,res){
  messaging_events = req.body.entry[0].messaging;
  for(i = 0; i<messaging_events.length; i++)
  {
    event = req.body.entry[0].messaging[i];
    sender = event.sender.id;
    if(event.message && event.message.text)
    {
      text = event.message.text;
      text = text.toLowerCase();
      
      if(text === '#joke' || text === 'joke')
      {
        sendJoke(sender);
        continue;
      }
      else if(text === 'hello' || text === '#help' || text === 'help' || text === 'get started' || text === 'hi' || text === 'yo')
      {
        var intro = "Hello ! I crack jokes about Rajinikanth !\n\n Here are my commands : \n\n\n #joke : I crack a random Rajinikanth joke \n\n #help | help : To See this message again";
        sendTextMessage(sender,intro);
      }
      else
      {
        var errmsg = "Um, I am a command based bot \n\n Try Again ? (try #help for command list)";
        sendTextMessage(sender,errmsg);
      }
      
    }
    else
    {
     if(event.postback && event.postback.payload === 'GET_STARTED_PAYLOAD')
      {
        var intro = "Hello ! I crack jokes about Rajinikanth !\n\n Here are my commands : \n\n\n #joke : I crack a random Rajinikanth joke \n\n #help | help : To See this message again";
        sendTextMessage(sender,intro);
      } 
    }
  }
  res.sendStatus(200);
});


function sendJoke(sender)
{
  var jokeUrl = 'https://api.rajinijokesdb.cf/jokes/random';
  request(jokeUrl,function(err,response,body){
    if(!err)
    {
      var info = JSON.parse(body);
      // parse specific val joke
      var joke = info.joke;
      sendTextMessage(sender,joke);
    }
  });
}

var token = process.env.FB_PAGE_ACCESS_TOKEN;

function sendTextMessage(sender,text)
{
  messageData = {text:text};
  request({
    url: 'https://graph.facebook.com/v2.6/me/messages',
    qs: {access_token:token},
    method: 'POST',
    json: {
            recipient: {id:sender},
            message: messageData,
        }
  },function(err,response,body){
    if (err) {
            console.log('Error sending messages: ', err)
        } else if (response.body.error) {
            console.log('Error: ', response.body.error)
        }
  });
}

app.get('/privacy/',function(req,res){
  res.sendfile('./policy/policy.html');
});

//server ON
app.listen(process.env.PORT);
console.log('Rajini Bot Is Activated... Behold the power of Rajini Anna ! :p');

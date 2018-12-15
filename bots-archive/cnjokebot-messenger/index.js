var express = require('express');
var bodyParser = require('body-parser');
var request = require('request');

var app = express();

var catList = ['explicit','dev','movie','food','celebrity','science','political','sport','religion','animal','music','history','travel','career','money','fashion'];

app.use(bodyParser.urlencoded({extended: false}));

app.use(bodyParser.json());

// index
app.get('/',function(req,res){
  res.send('Hello World ! I am a CN Joke Bot...');
});

// fb verify
app.get('/webhook/',function(req,res){
  if(req.query['hub.verify_token'] === 'abey_main_bot_hun_verify_kar'){
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
      if(text.indexOf('?') === 0 || text.indexOf('*') === 0 || text.indexOf('\\') === 0){
               // The '?,*,\' as start of a message was invalid regex and crashed the server. :D
               // This is temporary fix. Maybe we can validate the regex before passing text to soundEx / metaphone
               res.sendStatus(200);
               return;
             }
      else if(text === '#joke' || text === 'joke' || text === 'say a joke' || text === 'crack a joke' || text === 'tell me a joke' || text === 'tell a joke')
      {
        sendJoke(sender);
        continue;
      }
      else if(text.indexOf('#joke ') === 0)
      {
        sendCatJoke(sender, text.substring(text.indexOf(' ') + 1));
        continue;
      }
      else if(text === 'hello' || text === '#help' || text === 'help')
      {
        var intro = "Hello ! I crack jokes about Chuck Norris !\n\n Here are my commands : \n\n\n #joke : I crack a random joke \n\n #joke [category] : I crack a random joke based on a category provided\n(type 'help' in place of [category] for the categories supported) \n\n #help | help : To See this message again";
        sendTextMessage(sender,intro);
      }
      else
      {
        sendTextMessage(sender,text.substring(0,200));
      }
    }
  }
  res.sendStatus(200);
});

function sendCatJoke(sender,category)
{
  var category = category.toLowerCase();
  console.log(category);
  if(category === 'categories' || category === 'help' || category === 'category')
  {
    var helpText = "Here is a list of categories that I support : \n\n Explicit\n Dev(Developer)\n Movie\n Food\n Celebrity\n Science\n Political\n Sport\n Religion\n Animal\n Music\n History\n Travel\n Career\n Money\n Fashion";
    sendTextMessage(sender,helpText);
  }
  else if(catList.indexOf(category) >= 0)
  {
    var jokeUrl = 'https://api.chucknorris.io/jokes/random?category='+category;
    request(jokeUrl,function(err,response,body){
      if(!err)
      {
        var info = JSON.parse(body);
        var joke = info.value;
        sendTextMessage(sender,joke);
      }
    });
  }
  else
  {
    sendTextMessage(sender,"Whoa ! It seems you have entered a wrong category...");
  }
}

function sendJoke(sender)
{
  var jokeUrl = 'https://api.chucknorris.io/jokes/random';
  request(jokeUrl,function(err,response,body){
    if(!err)
    {
      var info = JSON.parse(body);
      var joke = info.value;
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
console.log('Bot IS ON...');

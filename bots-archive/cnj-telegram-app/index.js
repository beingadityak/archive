var TelegramBot = require('node-telegram-bot-api');
var token = process.env.TELEGRAM_API_KEY;
var request = require('request');

var joke_url = 'https://api.chucknorris.io/jokes/random';

var bot = new TelegramBot(token,{polling : true});
bot.getMe().then(function(me){
  console.log('Hi ! My Name is %s !',me.username);
});

bot.onText(/\/start/,function(msg,match){
  var fromId = msg.from.id;
  var message = "Welcome to the Chuck Norris Joke Bot !\n";
  message += "\nGet a random joke by sending /joke command\n";
  message += "\n\nMade by @beingadityak";

  bot.sendMessage(fromId,message);
});

bot.onText(/\/joke/,function(msg,match){
  var fromId = msg.from.id;
  sendAJoke(fromId);
});

function sendAJoke(id)
{
  request(joke_url,function(error,response,body){
    if(!error)
    {
      var info = JSON.parse(body);
      var joke = info.value;
      prepareAndSendMessage(joke,id);
    }
  });
}

function prepareAndSendMessage(jokeText,fromID)
{
  var message = "A Joke for you : \n";
  message += "\n" + jokeText + "\n";
  bot.sendMessage(fromID,message);
}

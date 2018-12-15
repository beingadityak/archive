console.log('The bot is starting...');

var twit = require('twit');
var config = require('./config');
var request = require('request');

var joke_url = 'https://api.chucknorris.io/jokes/random';

var T = new twit(config);

// User Stream...
var stream = T.stream('user');
stream.on('follow',followed);

function followed(eventMsg)
{
  var name = eventMsg.source.name;
  var screenName = eventMsg.source.screen_name;
  postFollowNotif('.@'+screenName+', Loved the joke !? follow my creator @beingadityak97 !');
}

//interval to crack a joke & post to twitter
crackAJoke();
setInterval(crackAJoke, 1000 * 60 * 60 * 4);  // crack a joke every 4 hours...

// function to crack a joke
function crackAJoke(){
  request(joke_url,function(error,response,body){
    if(!error)
    {
      var info = JSON.parse(body);
      var joke = info.value;
      //console.log(joke);

      // Make the bot say the joke
      postJoke(joke);
    }
  });
}

function postJoke(joke){
  var tweet = { status: joke + ' #jokeBotTweets'};
  T.post('statuses/update',tweet,tweeted);
}

function postFollowNotif(msg){
  var tweet = { status: msg};
  T.post('statuses/update',tweet,tweeted);
}

// function to post the tweet
function tweeted(err,data,response){
  if(err)
  {
    var errors = data.errors;
    for(i = 0 ; i < errors.length; i++)
      console.log("Error Message(s) : "+errors[i].message);
  }
  else {
  console.log(data.text);
  }
}

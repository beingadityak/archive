console.log('The bot is starting...');

var twit = require('twit');
var config = require('./config');
var request = require('request');

var joke_url = 'https://api.chucknorris.io/jokes/random';

var T = new twit(config);

// User Stream...
var stream = T.stream('user');
stream.on('follow',followed);


stream.on('tweet',tweetEvent);

function tweetEvent(eventMsg)
{
  var replyto = eventMsg.in_reply_to_screen_name;
  var text = eventMsg.text;
  var from = eventMsg.user.screen_name;

  if(replyto === 'c_n_jokebot')
  {
    if(catInTweet(text,'explicit') === true)
    {
      crackCatJoke(from,'explicit');
    }
    else if(catInTweet(text,'dev') === true)
    {
      crackCatJoke(from,'dev');
    }
    else if(catInTweet(text,'movie') === true)
    {
      crackCatJoke(from,'movie');
    }
    else if(catInTweet(text,'food') === true)
    {
      crackCatJoke(from,'food');
    }
    else if(catInTweet(text,'celebrity') === true)
    {
      crackCatJoke(from,'celebrity');
    }
    else if(catInTweet(text,'science') === true)
    {
      crackCatJoke(from,'science');
    }
    else if(catInTweet(text,'political') === true)
    {
      crackCatJoke(from,'political');
    }
    else if(catInTweet(text,'sport') === true)
    {
      crackCatJoke(from,'sport');
    }
    else if(catInTweet(text,'religion') === true)
    {
      crackCatJoke(from,'religion');
    }
    else if(catInTweet(text,'animal') === true)
    {
      crackCatJoke(from,'animal');
    }
    else if(catInTweet(text,'music') === true)
    {
      crackCatJoke(from,'music');
    }
    else if(catInTweet(text,'history') === true)
    {
      crackCatJoke(from,'history');
    }
    else if(catInTweet(text,'travel') === true)
    {
      crackCatJoke(from,'travel');
    }
    else if(catInTweet(text,'career') === true)
    {
      crackCatJoke(from,'career');
    }
    else if(catInTweet(text,'money') === true)
    {
      crackCatJoke(from,'money');
    }
    else if(catInTweet(text,'fashion') === true)
    {
      crackCatJoke(from,'fashion');
    }
    else
    {
      postReply('@'+from+' thanks for mentioning me !');
    }
  }
}

function catInTweet(s,word)
{
return new RegExp('\\b' + word + '\\b','i').test(s);
}


function followed(eventMsg)
{
  var name = eventMsg.source.name;
  var screenName = eventMsg.source.screen_name;
  postFollowNotif('.@'+screenName+', Loved the joke !? follow my creator @beingadityak97 !');
}

//interval to crack a joke & post to twitter
crackAJoke();
setInterval(crackAJoke, 1000 * 60 * 30);  // crack a joke every 30 minutes...

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

function crackCatJoke(username,cat)
{
  var cat_joke_url = 'https://api.chucknorris.io/jokes/random?category='+cat;
  request(cat_joke_url,function(error,response,body){
    if(!error)
    {
      var info = JSON.parse(body);
      var joke = info.value;
      //console.log(joke);

      // Make the bot say the joke
      postReply('@'+username+' '+joke);
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

function postReply(replytext)
{
  var tweet = {status : replytext};
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

'use strict'

console.log("The GIPHY Bot is starting...");

var twit = require('twit');
var config = require('./config');
var request = require('request');
var fs = require('fs');
var path = require('path');

const GIPHY_API_KEY = 'dc6zaTOxFJmzC';

const GIPHY_API_URL = 'http://api.giphy.com/v1/gifs/random?api_key='+GIPHY_API_KEY+'&tag=study';

var T = new twit(config);

getAndPostGifImg();

function getAndPostGifImg()
{
  request(GIPHY_API_URL,function (error,response,body) {
    var resp = JSON.parse(body);
    var img_url = resp.data.image_url;
    console.log(img_url);
    // post the image to twitter

    postImg(img_url);
  });

  function postImg(img_url)
  {
     request(img_url).pipe(fs.createWriteStream('images/imgpost.gif'));

     var filename = __dirname+'/images/imgpost.gif';
     var params = {
       encoding: 'base64'
     };

     var img = fs.readFileSync(filename,params);

     T.post('media/upload', { media_data: img }, onUpload);

    function onUpload(err,data,response)
    {
      if(err){
        console.log(err.code);
        console.log(err.message);
      }
      var idStr = data.media_id_string;
      console.log(idStr);
      // post a tweet /hashtag along with image
      var tweet = {
        status: 'random Study Tweet #giphyBotTweets',
        media_ids: [idStr]
      };
      T.post('statuses/update',tweet, tweeted);
    }

    function tweeted(err,data,response){
      if(err){
        var errors = data.errors;
        var i = 0;
        for(i = 0 ; i < errors.length; i++)
          console.log("Error Message(s) : "+errors[i].message);
      }
      else {
        console.log(data.text);
      }
    }
  }
}

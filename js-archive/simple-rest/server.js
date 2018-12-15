var express = require('express');
var app = express();
var bodyParser = require('body-parser');

const MONGO_URL = 'mongodb://beingadityak:windows@ds115870.mlab.com:15870/simple-rest';

var mongoose = require('mongoose');
mongoose.connect(MONGO_URL);
var Bear = require('./app/models/bear');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port = process.env.PORT || 8888;

var router = express.Router();

//middleware
router.use(function(req,res,next) {
  console.log('Something happened...');
  next();
});

router.get('/',function(req,res){
  res.json({message : 'Hello ! Welcome to our API !!'});
});

router.route('/bears')
      .post(function(req,res){
        var bear = new Bear();
        bear.name = req.body.name;

        //save the bear
        bear.save(function(err){
          if(err)
          {
            res.send(err);
            console.log(err);
          }

          res.json({message : 'Bear created !'});
        });
      })

      .get(function(req,res) {
        Bear.find(function(err,bears){
          if(err)
          {
            res.send(err);
            console.log(err);
          }
          res.json(bears);
        });
      });

router.route('/bears/:bear_id')
      .get(function(req,res){
        var query = Bear.findById(req.params.bear_id).select('name');
        query.exec(function(err,bear){
          if(err)
          {
            res.send(err);
            console.log(err);
          }
          res.json(bear);
        })
      })
      .put(function(req,res) {
        Bear.findById(req.params.bear_id,function(err,bear){
            if(err)
            {
              res.send(err);
              console.log(err);
            }
            bear.name = req.body.name;
            bear.save(function(err) {
              if(err)
              {
                res.json({message: "Something went wrong !"});
                console.log(err);
              }
              res.json({message : "Bear Updated !"});
            });
        });
      })
      .delete(function(req, res) {
        Bear.remove({
            _id: req.params.bear_id
        }, function(err, bear) {
            if (err)
                res.send(err);

            res.json({ message: 'Successfully deleted' });
        });
    });
// more routes

app.use('/api',router);

app.get('/',function(req,res){
  res.send("Hello World ! Use /api to access our API");
});

app.listen(port);

console.log("PORT IS : "+port);

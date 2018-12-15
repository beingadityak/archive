<?php

//error_reporting(-1);
//ini_set('display_errors', 1);

require 'vendor/autoload.php';
require 'app/database.php';

use Slim\Slim;
use \Rajinijokesdb\Models\Joke;

  $app = new Slim();
  $app->config([
    'baseUrl' => 'http://localhost/rajinijokesdb'
  ]);
$app->response->headers->set('Content-Type', 'application/json');

  $app->get('/',function(){
    echo 'You shall get a random Rajinikant Joke !';
  });

  $app->get('/jokes/random',function() use ($app) {
    $joke = Joke::orderByRaw('RAND()')->take(1)->first();
    if(!$joke)
    {
        $app->notFound();
    }
    $app->response->setStatus(201);
    return $app->response->write(json_encode([
      'joke' => $joke->joke
    ]));
  });

$app->get('/jokes',function() use ($app) {
    $jokes = Joke::select('joke')->get();
    $jokes = $jokes->map(function($item, $key){
      return $item->joke;
    });

    if(!$jokes)
    {
        $app->notFound();
    }
    $app->response->setStatus(200);
    return $app->response->write(json_encode(
      $jokes->toArray()
    ));
  });

$app->post('/joke',function() use ($app){
    $payload = json_decode($app->request->getBody());
    if(empty($payload) || empty(trim($payload->joke)))
    {
      $app->response->setStatus(400);
      return $app->response->write(json_encode([
        'error'=> [
          'code'=> 400,
          'message' => 'A Joke is required'
        ]
      ]));
    }
    
    
    $newJoke = Joke::create([
      'joke' => $payload->joke
    ]);
    $app->response->setStatus(200);
    return $app->response->write(json_encode([
      'message' => 'joke added successfully !',
      'added' =>
        ['joke'=> $newJoke->joke]
    ]));
  });

?>

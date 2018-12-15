<?php

  use Slim\Slim;
  use \ShortR\Models\Link;

  //debug
  ini_set('display_errors','On');

  require '../vendor/autoload.php';
  require 'database.php';

  $app = new Slim();

  $app->config([
    'baseUrl' => 'http://localhost/shortener/public'
  ]);

  $app->get('/',function(){
    echo 'Pass in a short URL to get a full URL';
  });

  $app->get('/:code',function($code) use ($app) {
    $link = Link::where('code',$code)->first();

    if(!$link)
    {
        $app->notFound();
    }

    $app->response->redirect($link->url);
  });

  $app->post('/api/generate',function() use ($app){
    $payload = json_decode($app->request->getBody());

    if(empty($payload) || empty(trim($payload->url)))
    {
      $app->response->setStatus(400);

      return $app->response->write(json_encode([
        'error'=> [
          'code'=> 1000,
          'message' => 'A URL is required'
        ]
      ]));
    }

    if(!filter_var($payload->url, FILTER_VALIDATE_URL))
    {
      $app->response->setStatus(400);

      return $app->response->write(json_encode([
        'error'=> [
          'code'=> 1001,
          'message' => 'A valid URL is required'
        ]
      ]));
    }

    $link = Link::where('url',$payload->url)->first();

    if($link)
    {
      $app->response->setStatus(201);

      return $app->response->write(json_encode([
        'url' => $payload->url,
        'generated' =>[
          'url'=> $app->config('baseUrl'). '/' . $link->code,
          'code'=> $link->code
        ]
      ]));
    }

    $newLink = Link::create([
      'url' => $payload->url
    ]);

    $newCode = substr(sha1(microtime()),5,5);

    $newLink->update([
      'code' => $newCode
    ]);

    $app->response->setStatus(201);

    return $app->response->write(json_encode([
      'url' => $payload->url,
      'generated' =>[
        'url'=> $app->config('baseUrl'). '/' . $newLink->code,
        'code'=> $newLink->code
      ]
    ]));

  });

?>

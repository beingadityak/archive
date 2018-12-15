<?php

namespace Rajinijokesdb\Models;
  use Illuminate\Database\Eloquent\Model as Eloquent;
  class Joke extends Eloquent
  {
      public $table = 'jokes';
      public $fillable = ['joke'];
  }

?>
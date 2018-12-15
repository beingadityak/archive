<?php
require_once 'classes/Shortener.php';

if(isset($_GET['code'])){
    $s = new Shortener;
    $code = $_GET['code'];

    if($url = $s->getUrl($code)){
        $s->addClick($code);
        header("location:{$url}");
        die();
    }
}

header('location:index.php');
?>
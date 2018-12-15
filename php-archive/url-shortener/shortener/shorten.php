<?php
session_start();
require_once 'classes/Shortener.php';

$s = new Shortener;

if(isset($_POST['url']))
    {
    $url = $_POST['url'];

    if($code = $s->makeCode($url))
        {
            $_SESSION['feedback'] = "Generated ! Your short URL is : <a href = \"http://localhost:2020/shortener/{$code}\">http://localhost:2020/shortener/{$code}</a>";
        }
    else
        {
            // Some problem ...

            $_SESSION['feedback'] = "There was a problem. Invalid URL?";
        }
    }
header('location:index.php');
?>
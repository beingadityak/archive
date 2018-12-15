<?php

require_once 'classes/Shortener.php';

$s = new Shortener;

if(isset($_GET['url']))
    {
        if(!filter_var($_GET['url'],FILTER_VALIDATE_URL) === false)
            {
            $url = $_GET['url'];
            if($code = $s->makeCode($url))
                {
                $data = array("url" => "http://localhost:2020/shortener/{$code}");
                }
            else
                {
                $data = array("url" => "Generation Error");
                }
            }
        else
            {
                $data = array("url" => "Invalid URL");
            }
    }
header('Content-Type: application/json;charset=utf8');
echo json_encode($data,JSON_UNESCAPED_SLASHES);

?>
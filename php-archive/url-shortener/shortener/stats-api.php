<?php

require_once 'classes/Shortener.php';

$s = new Shortener;

if(isset($_GET['url']))
    {
        if(!filter_var($_GET['url'],FILTER_VALIDATE_URL) === false)
            {
            $url = $_GET['url'];
            $id = substr($url, strrpos($url, '/') + 1);
            if($stats = $s->getStats($id))
                {
                $data = array("message"=>"Success",
                              "short-url" => "http://localhost:2020/shortener/{$id}",
                              "long-url"=>"{$stats["url"]}",
                              "created"=>"{$stats["created"]}",
                              "clicks"=>"{$stats["clicks"]}");
                }
            else
                {
                $data = array("message" => "Stats Error !");
                }
            }
        else
            {
                $data = array("message" => "Invalid URL");
            }
    }
header('Content-Type: application/json;charset=utf8');
echo json_encode($data,JSON_UNESCAPED_SLASHES);

?>
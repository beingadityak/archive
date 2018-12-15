<html>
<head>
<title>Stats for http://localhost:2020/shortener/<?php echo $_GET['code'];?></title>
<link rel = "stylesheet" href = "css/style.css"/>
</head>
<body>
    <?php
    require_once 'classes/Shortener.php';

    if(isset($_GET['code']))
        {
            $s = new Shortener;
            $code = $_GET['code'];

            if($stats = $s->getStats($code))
            {?>
            <div class = "container">
            <h1>:: Stats for your Short Link ::</h1>
                <?php
                echo "Short URL : <a href = 'http://localhost:2020/shortener/".$_GET['code']."'>http://localhost:2020/shortener/".$_GET['code']."</a><br/><br/>";
                echo "Long URL : <a href = '".$stats["url"]."'>".$stats["url"]."</a><br/><br/>";
                echo "Creation Date : ".$stats["created"]."<br/><br/>";
                echo "No. of clicks (till now) : ".$stats["clicks"]."<br/><br/>";
                die();
            }
            else
            {
                header("location:index.php");
                die();
            }
        }
    ?>
    </div>
</body>
</html>
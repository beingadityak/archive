<?php
session_start();
?>

<!doctype html>
<html>
    <head>
        <meta charset = "utf-8">
        <title> URL Shortener </title>
        <link rel = "stylesheet" href = "css/style.css"/>
    </head>
    <body>
        <div class = "container">
            <h1 class = "title"> Shorten A URL </h1>

            <?php
            if(isset($_SESSION['feedback']))
                {
                    echo "<p>{$_SESSION['feedback']}</p>";
                    unset($_SESSION['feedback']);
                }
            ?>

            <form action = "shorten.php" method = "post">
                <input type = "url" name = "url" placeholder = "Enter A URL" autocomplete = "off">
                <input type = "submit" value = "Shorten">
            </form>
        </div>
    </body>
</html>
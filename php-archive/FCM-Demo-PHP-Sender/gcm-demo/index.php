<?php
        // Enabling error reporting
        error_reporting(-1);
        ini_set('display_errors', 'On');
 
        require_once __DIR__ . '/firebase.php';
        require_once __DIR__ . '/push.php';
 
        $firebase = new Firebase();
        $push = new Push();
 
        // optional payload
        $payload = array();
        $payload['team'] = 'India';
        $payload['score'] = '5.6';
 
        // notification title
        $title = isset($_GET['title']) ? $_GET['title'] : '';
         
        // notification message
        $message = isset($_GET['message']) ? $_GET['message'] : '';
         
        // push type - single user / topic
        $push_type = isset($_GET['push_type']) ? $_GET['push_type'] : '';
         
        // whether to include to image or not
        $include_image = isset($_GET['include_image']) ? TRUE : FALSE;
 
 
        $push->setTitle($title);
        $push->setMessage($message);
        if ($include_image) {
            $push->setImage('http://api.androidhive.info/images/minion.jpg');
        } else {
            $push->setImage('');
        }
        $push->setIsBackground(FALSE);
        $push->setPayload($payload);
 
 
        $json = '';
        $response = '';
 
        if ($push_type == 'topic') {
            $json = $push->getPush();
            $response = $firebase->sendToTopic('global', $json);
        } else if ($push_type == 'individual') {
            $json = $push->getPush();
            $regId = isset($_GET['regId']) ? $_GET['regId'] : '';
            $response = $firebase->send($regId, $json);
        }
        ?>
<html>
    <head>
    <title>FCM DEMO</title>
    </head>

    <body>
    <form method="get">
                <fieldset>
                    <legend>Send to Topic `global`</legend>
 
                    <label for="title1">Title</label>
                    <input type="text" id="title1" name="title" placeholder="Enter title">
 
                    <label for="message1">Message</label>
                    <textarea name="message" id="message1" rows="5" placeholder="Notification message!"></textarea>
 
                    <label for="include_image1">
                        <input id="include_image1" name="include_image" type="checkbox"> Include image
                    </label>
                    <input type="hidden" name="push_type" value="topic"/>
                    <button type="submit" >Send to Topic</button>
                </fieldset>
            </form>
    </body>
</html>
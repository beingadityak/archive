<html>
  <head>
    <title>JSON testing</title>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <link href="form-style.css" rel="stylesheet">
    <style>
    
    </style>
    <script type="text/javascript">
      var num_array = ["first","second","third","forth","fifth","sixth","seventh","eighth","ninth","tehtn","eleventh"];
      
      var current = 0;
      function add_event() {
	
      }
    </script>
  </head>
  
  <body>
    
<?php
// $json = '{"technical": {"ce": {"name":"Computer", "tag":"insilico","first": {"id":"234"} }}}';
// 
// var_dump(json_decode($json));
// echo "<br><br>";
// var_dump(json_decode($json, true));
// echo "<br><br><br>";
// $new = json_decode($json);
// var_dump(json_encode($new));

$myfile = fopen("technical/js/ntechnical.json", "r") or die("Unable to open file!");
  $data = fread($myfile,filesize("technical/js/ntechnical.json"));
  $new_data = str_replace("data=","",$data);
  
  $data = json_decode($new_data,true);
//   var_dump($data);
  var_dump($data);
  fclose($myfile);
  $branch = "it";
  

?>

<br><br><br>

<div class="container-fluid" style="width: 65%;">
  <div class="row">
    <div class="col-md-12">
      <ul class="nav nav-tabs row">
	<li class="active col-md-6"><a data-toggle="tab" href="#home">New event</a></li>
	<li class="col-md-6"><a data-toggle="tab" href="#menu1">Edit</a></li>
      </ul>
    </div>
  </div>
  
  
  <div class="row">
    <div class="col-md-12">
      <div class="tab-content">
	<div id="home" class="tab-pane fade in active">
	   
	  <?php
	    if(isset($_GET['event'])) {
	  ?>
	    <div class="container-fluid">
	  <br>
	  <form action="" method="post">
	    <div class="container-fluid">
	      <center>
	      <!--<div class="form-group" style="width: 60%;">
		    <label for="branch">Branch:</label>
		    <select name="branch" class="form-control" id="branch">
		      <option value="ce">Insilico (CE)</option>
		      <option value="it">Tech Crusade (IT)</option>
		      <option value="ch">Insilico (CE)</option>
		      <option value="mh">Insilico (CE)</option>
		    </select>
	      </div>-->
	      </center>
	      <hr>
	      <div class="row">
		<div class="col-md-12">
		  <div class="form-group">
		    <label for="name">Name:</label>
		    <input type="text" class="form-control" id="name" placeholder="Name of event" name="name" value="<?php echo $data["technical"][$branch][$_GET['event']]["name"];?>">
		  </div>
		</div>
	      </div>
	      	      
	      <div class="row">
		<div class="col-md-12">
		  <div class="form-group">
		    <label for="tagline">Tagline:</label>
		    <input type="text" class="form-control" id="tagline" placeholder="Tagline" name="tagline" value="<?php echo $data["technical"][$branch][$_GET['event']]["tagline"];?>">
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="description">Description:</label>
		    <textarea class="form-control" id="description" placeholder="Description" rows="10" name="description"><?php echo $data["technical"][$branch][$_GET['event']]["description"];?></textarea>
		  </div>
		</div>
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="rules">Rules:</label>
		    <textarea class="form-control" id="rules" placeholder="Rules of the event" rows="10" name="rules"><?php echo $data["technical"][$branch][$_GET['event']]["rules"];?></textarea>
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="date">Date:</label>
		    <input type="text" class="form-control" id="date" placeholder="Date" name="date" value="<?php echo $data["technical"][$branch][$_GET['event']]["date"];?>">
		  </div>
		</div>
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="time">Time:</label>
		    <input type="text" class="form-control" id="time" placeholder="Timing" name="time" value="<?php echo $data["technical"][$branch][$_GET['event']]["time"];?>">
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="venue">Venue:</label>
		    <input type="text" class="form-control" id="venue" placeholder="Venue" name="venue" value="<?php echo $data["technical"][$branch][$_GET['event']]["venue"];?>">
		  </div>
		</div>
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="fees">Fees:</label>
		    <input type="text" class="form-control" id="fees" placeholder="Fees (per team or individual)" name="fees" value="<?php echo $data["technical"][$branch][$_GET['event']]["fees"];?>">
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-12">
		  <div class="form-group">
		    <label for="contact">Contact:</label>
		    <textarea class="form-control" id="contact" placeholder="Co-ordinators to contact" rows="3" name="contact"><?php echo $data["technical"][$branch][$_GET['event']]["contact"];?></textarea>
		  </div>
		</div>
	      </div>
	      <input type="hidden" name="event" value="<?php echo $_GET['event']; ?>">
	      <button type="submit" class="btn btn-default" name="edit">Submit</button>
	    </div>
	  </form>

	  </div>
	  <?php
	    }
	    else {
	  ?>
	  
	  <div class="container-fluid">
	  <br>
	  <form action="" method="post">
	    <div class="container-fluid">
	      <center>
	      <!--<div class="form-group" style="width: 60%;">
		    <label for="branch">Branch:</label>
		    <select name="branch" class="form-control" id="branch">
		      <option value="ce">Insilico (CE)</option>
		      <option value="it">Tech Crusade (IT)</option>
		      <option value="ch">Insilico (CE)</option>
		      <option value="mh">Insilico (CE)</option>
		    </select>
	      </div>-->
	      </center>
	      <hr>
	      <div class="row">
		<div class="col-md-12">
		  <div class="form-group">
		    <label for="name">Name:</label>
		    <input type="text" class="form-control" id="name" placeholder="Name of event" name="name">
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-12">
		  <div class="form-group">
		    <label for="tagline">Tagline:</label>
		    <input type="text" class="form-control" id="tagline" placeholder="Tagline" name="tagline">
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="description">Description:</label>
		    <textarea class="form-control" id="description" placeholder="Description" rows="10" name="description"></textarea>
		  </div>
		</div>
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="rules">Rules:</label>
		    <textarea class="form-control" id="rules" placeholder="Rules of the event" rows="10" name="rules"></textarea>
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="date">Date:</label>
		    <textarea class="form-control" id="date" placeholder="Date" name="date"> </textarea>
		  </div>
		</div>
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="time">Time:</label>
		    <textarea class="form-control" id="time" placeholder="Timing" name="time"> </textarea>
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-6">
		  <div class="form-group">
		    <label for="venue">Venue:</label>
		    <textarea class="form-control" id="venue" placeholder="Venue" name="venue"> </textarea>
		  </div>
		</div>
		<div class="col-md-3">
		  <div class="form-group">
		    <label for="teamsize">Team size : </label>
		    <input type="text" class="form-control" id="teamsize" placeholder="Members per team" name="teamsize">
		  </div>
		</div>
		<div class="col-md-3">
		  <div class="form-group">
		    <label for="fees">Fees:</label>
		    <input type="text" class="form-control" id="fees" placeholder="Fees (per team or individual)" name="fees">
		  </div>
		</div>
	      </div>
	      
	      <div class="row">
		<div class="col-md-12">
		  <div class="form-group">
		    <label for="contact">Contact:</label>
		    <textarea class="form-control" id="contact" placeholder="Co-ordinators to contact" rows="3" name="contact"></textarea>
		  </div>
		</div>
	      </div>
	      
	      <button type="submit" class="btn btn-default" name="new">Submit</button>
	    </div>
	  </form>

	  </div>
	  <?php } ?>
	</div>
	<div id="menu1" class="tab-pane fade">
	  
	  <div id="events">
	    <?php
	      $nums = array("first","second","third","forth","fifth","sixth","seventh","eighth","ninth","tehtn","eleventh");
	      
// 	      echo $data["technical"][$branch]["totalevents"];
	      for($i=0; $i < $data["technical"][$branch]["totalevents"];$i++) {
// 		echo $data["technical"][$branch][$nums[$i]]["name"]."<BR>";
	    ?>
	      <a href="?event=<?php echo $nums[$i];?>"> 
		<?php echo $data["technical"][$branch][$nums[$i]]["name"];?>
	      </a> : 
	      <a href="?event=<?php echo $nums[$i];?>&action=delete"> 
		Delete
		<?php //echo $data["technical"][$branch][$nums[$i]]["name"];?>
	      </a>
	      <br>
	    <?php
	      }
	    ?>
	  </div>
	</div>
      </div>
    </div>
  </div>
</div>



<?php
    function convertq($string)
{
    $search = array('&',
                    '<',
                    '>',
                    '"',
                    chr(212),
                    chr(213),
                    chr(210),
                    chr(211),
                    chr(209),
                    chr(208),
                    chr(201),
                    chr(145),
                    chr(146),
                    chr(147),
                    chr(148),
                    chr(151),
                    chr(150),
                    chr(133),
                    chr(194)
                );

     $replace = array(  '&amp;',
                        '&lt;',
                        '&gt;',
                        '&quot;',
                        '&#8216;',
                        '&#8217;',
                        '&#8220;',
                        '&#8221;',
                        '&#8211;',
                        '&#8212;',
                        '&#8230;',
                        '&#8216;',
                        '&#8217;',
                        '&#8220;',
                        '&#8221;',
                        '&#8211;',
                        '&#8212;',
                        '&#8230;',
                        ''
                    );

    return str_replace($search, $replace, $string);
}
  if(isset($_POST['new']) || isset($_POST['edit'])) {
  
    $nums = array("first","second","third","forth","fifth","sixth","seventh","eighth","ninth","tehtn","eleventh");
  
    $event = array();
    $event["name"] = $_POST["name"];
    $event["name"] = convertq($event["name"]); 
    $event["tagline"] = $_POST["tagline"];
    $event["tagline"] = convertq($event["tagline"]); 
    $event["description"] =  $_POST["description"];
    $event["description"] = convertq($event["description"]);  
    $event["rules"] = $_POST["rules"];
    $event["rules"] = convertq($event["rules"]); 
    $event["teamsize"] = $_POST["teamsize"];
    $event["teamsize"] = convertq($event["teamsize"]); 
    $event["date"] = $_POST["date"];
    $event["date"] = convertq($event["date"]); 
    $event["time"] = $_POST["time"];
    $event["time"] = convertq($event["time"]); 
    $event["venue"] = $_POST["venue"];
    $event["venue"] = convertq($event["venue"]); 
    $event["fees"] = $_POST["fees"];
    $event["fees"] = convertq($event["fees"]); 
    $event["contact"] = $_POST["contact"];
    $event["contact"] = convertq($event["contact"]); 
    $event_no = $data["technical"][$branch]["totalevents"]; 
    
    if(isset($_POST['edit'])) {
	$data["technical"][$branch][$_POST['event']] = $event;
    }
    else {
      $data["technical"][$branch][$nums[$event_no]] = $event;
      $data["technical"][$branch]["totalevents"] = intval($event_no)+1;
    }
    
    var_dump(json_encode($data));
   
    $myfile = fopen("technical/js/ntechnical.json", "w") or die("<br><br><br>Unable to open file!");
    fwrite($myfile, "data=".json_encode($data));
    fclose($myfile);
    
//     var_dump($data["technical"][$branch]);
  }
//   var_dump(json_encode($data));/*

?>
  </body>

</html>
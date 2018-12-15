<html>
<head>
<link rel = "stylesheet" type = "text/css" href = "table.css">
<meta name = "viewport" content="width=device-width, initial-scale=1.0">
<link href='http://fonts.googleapis.com/css?family=Roboto:100,300' rel='stylesheet' type='text/css'>
<title>DDIT Results</title>
</head>
<body>
<?php
require("./simplehtmldom/simple_html_dom.php");
function getResults($egovid, $birthdate, $examtype, $currentsem, $batchyear) {
    	$cookie_file_path = "cookie.txt";	
		if(file_exists($cookie_file_path))
		    unlink($cookie_file_path);
	   
		$ch = curl_init();
		
		curl_setopt ($ch, CURLOPT_POST, TRUE);
		curl_setopt ($ch, CURLOPT_POSTFIELDS, "LoginForm[username]=".$egovid."&LoginForm[password]=".$birthdate."");
		curl_setopt ($ch, CURLOPT_RETURNTRANSFER, TRUE);
		curl_setopt ($ch, CURLOPT_HEADER, 0);
		curl_setopt ($ch, CURLOPT_FOLLOWLOCATION, 1);
		curl_setopt($ch, CURLOPT_AUTOREFERER, TRUE);
		curl_setopt ($ch, CURLOPT_COOKIEJAR, $cookie_file_path);
		curl_setopt ($ch, CURLOPT_COOKIEFILE, $cookie_file_path);
			
		curl_setopt($ch, CURLOPT_URL,'http://egov.ddit.ac.in/index.php?r=site/login');	
		$output1 = curl_exec($ch);
		 
		curl_setopt($ch, CURLOPT_URL,'http://egov.ddit.ac.in/index.php?r=tblstudentmst/academicHistory');
		$output2 = curl_exec($ch);
		
		curl_setopt ($ch, CURLOPT_POST, TRUE);
		curl_setopt ($ch, CURLOPT_POSTFIELDS, "sessionno=".$currentsem."&batchyear=".$batchyear."");
		curl_setopt($ch, CURLOPT_URL,'http://egov.ddit.ac.in/index.php?r=tblstudentmst/'.$examtype.'Relational');
		$output3 = curl_exec($ch);
		$html = str_get_html($output3);
    
    //remove additional spaces
		$pat[0] = "/^\s+/";
		$pat[1] = "/\s{2,}/";
		$pat[2] = "/\s+\$/";
		$rep[0] = "";
		$rep[1] = " ";
		$rep[2] = "";
    
    $ret = $html->find('div[id=content]');
    $checknew = $ret[0];
    
	foreach($html->find('input[type="submit"]') as $e)
		{
			$e->outertext = '';
		}
	
    if(file_exists($cookie_file_path))
        unlink($cookie_file_path);
    
    return $checknew;
	}
$egovid = $_POST['egovid'];
$birthdate = $_POST['dob']."/".$_POST['mob']."/".$_POST['yob'];
$examtype = $_POST['type'];
$currentsem = $_POST['sem'];
$batchyear = $_POST['curryear'];
echo getResults($egovid,$birthdate,$examtype,$currentsem,$batchyear);
echo "<br/><center><a href = 'index.php'>Try Another</a></center>";
?>
</body>
</html>
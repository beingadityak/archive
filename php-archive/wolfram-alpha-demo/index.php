<html>
   <head>
	  <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.teal-blue.min.css">
      <script src="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
      <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	  <title>Antaryaami</title>
   </head>
<body>
   <!-- The drawer is always open in large screens. The header is always shown,  even in small screens. -->
   <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-layout--fixed-tabs">
      <header class="mdl-layout__header">
         <!-- Top row, always visible -->
         <div class="mdl-layout__header-row">
         <!-- Title -->
            <span class="mdl-layout-title">Antaryaami</span>          
         </div>
      </header>
      <main class="mdl-layout__content">
         <section class="mdl-layout__tab-panel is-active" id="home">
            <div class="page-content">
				<h3>Home</h3>
				<br/><br/>
				<form action = "index.php" method = "get">
					<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
						<input class="mdl-textfield__input" type="text" id="query" name = "q">
						<label class="mdl-textfield__label" for="query">Your Query</label>
					</div>
					<input type = "submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored" value = "Find Answer">
				</form>
				<br/><br/><br/>
				<?php
				if(isset($_REQUEST['q']))
					{
					$APP_ID="YOUR-API-KEY-HERE"; // download your api key from http://developer.wolframalpha.com
					$INPUT=$_REQUEST['q'];
					$URL = "http://api.wolframalpha.com/v2/query?input=".urlencode($INPUT)."&appid=".$APP_ID;
					$ch1=curl_init();
					curl_setopt($ch1,CURLOPT_URL,$URL);
					curl_setopt($ch1,CURLOPT_FOLLOWLOCATION,FALSE);
					curl_setopt($ch1,CURLOPT_RETURNTRANSFER,TRUE);
					curl_setopt($ch1,CURLOPT_HEADER,TRUE);
					$resp=curl_exec($ch1);
					preg_replace('/&amp;/', '&', $resp);
					preg_match_all('%<pod title=\'(.*?)\'\s*.*?>\s*<subpod.*?>\s*<plaintext>(.*?)</plaintext>\s*(?:<img src=\'(.*?)\')?%si', $resp, $rarr);
					if(empty($rarr))
					{
						echo "Sorry ! I was unable to answer that ... ";
					}
					echo "<table>";
					for($i=0; $i<count($rarr[0]);$i++){
							if($rarr[2][$i]==""){
								echo "<tr> <td> ".$rarr[1][$i]."</td><td><img src=\"".$rarr[3][$i]."\"/></td></tr>";
							}
							else{
		
								echo "<tr> <td> ".$rarr[1][$i]."</td><td>".$rarr[2][$i]."</td></tr>";
								}
						}
					echo "</table>";

					}
				?>
			</div>
         </section>
      </main>
   </div>
</body>
</html>


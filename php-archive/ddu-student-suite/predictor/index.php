<html>
<head>
<title>DDIT Predictor(Web)</title>
<link href='https://fonts.googleapis.com/css?family=Roboto:100' rel='stylesheet' type='text/css'>
 <link rel="stylesheet" href="https://code.getmdl.io/1.1.3/material.teal-cyan.min.css" />  
<script src="https://storage.googleapis.com/code.getmdl.io/1.0.6/material.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
      <header class="mdl-layout__header">
         <div class="mdl-layout__header-row">
            <span class="mdl-layout-title">DDIT Predictor(Web)</span>
		 </div>
	  </header>
<div class="mdl-layout__drawer">
         <span class="mdl-layout-title">Menu</span>
         <nav class="mdl-navigation">
            <a class="mdl-navigation__link" href="../index.html">Home</a>
            <a class="mdl-navigation__link" href="index.php">DDIT Predictor</a>
			<a class="mdl-navigation__link" href="../fetch-result/index.php">DDIT Result Fetcher</a>
         </nav>
      </div>
	  <main class="mdl-layout__content">
         <div class="page-content">
			<table>
				<tr><td><h2>DDIT Predictor(Web Version)</h2></td></tr>
				<form action = <?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?> method = "post">
					<tr>
					<td>Sessional 1 Marks (out of 36) : </td>
					<td>
						<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
							<input class="mdl-textfield__input" type="number" min="0"max="36" step="1" id="sess1" name="sess1" required <?php if(isset($sess1)) {echo "value=".$sess1;}?> >
							<label class="mdl-textfield__label" for="sess1">Sessional 1 Marks</label>
						</div>
					</td>
					</tr>
					<tr>
					<td>Sessional 2 Marks (out of 36) : </td>
					<td>
						<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
							<input class="mdl-textfield__input" type="number" min="0"max="36" step="1" id="sess2" name="sess2" required <?php if(isset($sess2)) {echo "value=".$sess2;}?>>
							<label class="mdl-textfield__label" for="sess2">Sessional 2 Marks</label>
						</div>
					</td>
					</tr>
					<tr>
					<td>Sessional 3 Marks (out of 36) : </td>
					<td>
						<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
							<input class="mdl-textfield__input" type="number" min="0"max="36" step="1" id="sess3" name="sess3" required <?php if(isset($sess3)) {echo "value=".$sess3;}?>>
							<label class="mdl-textfield__label" for="sess3">Sessional 3 Marks</label>
						</div>
					</td>
					</tr>
					<tr>
					<td>Total Marks : </td>
					<td>
						<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="total">
						<input type="radio" id="total" value="150" name="total" class="mdl-radio__button" onchange="changeVal(this)" <?php if(isset($total) && $total == '150') {echo "checked";}?> >
						<span class="mdl-radio__label">150</span>
						</label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<label class="mdl-radio mdl-js-radio mdl-js-ripple-effect" for="total2">
						<input type="radio" id="total2" value="100" name="total" class="mdl-radio__button" onchange="changeVal(this)" <?php if(isset($total) && $total == '100') {echo "checked";}?>>
						<span class="mdl-radio__label">100</span>
						</label>
					</td>
					</tr>
					<tr>
					<td>Practical+Viva Marks (out of 50) : </td>
					<td>
						<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
							<input class="mdl-textfield__input" type="number" min="0"max="50" step="1" id="pracviva" name="pracviva" required <?php if(isset($pracviva)) {echo "value=".$pracviva;}?>>
							<label class="mdl-textfield__label" for="pracviva">Practical+Viva Marks</label>
						</div>
					</td>
					</tr>
					<tr>
					<td>Target SPI (Between 6 to 10) : </td>
					<td>
						<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
							<input class="mdl-textfield__input" type="number" min="6"max="10" step="1" id="targetspi" name="targetspi" required <?php if(isset($targetspi)) {echo "value=".$targetspi;}?>>
							<label class="mdl-textfield__label" for="targetspi">Target SPI</label>
						</div>
					</td>
					</tr>
					<tr>
					<td>Attendance Marks (1 to 4) : </td>
					<td>
						<div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
							<input class="mdl-textfield__input" type="number" min="0"max="4" step="1" id="att" name="att" required <?php if(isset($att)) {echo "value=".$att;}?>>
							<label class="mdl-textfield__label" for="att">Attendance Marks</label>
						</div>
					</td>
					</tr>
					<tr>
					<td><center><button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored" type = "submit">Predict</button></center></td>
					</tr>
				</form>
			</table>
		<?php
			if(!empty($_POST))
				{
					$sess1 = $_POST['sess1'];
					$sess2 = $_POST['sess2'];
					$sess3 = $_POST['sess3'];
					$avg = ($sess1 + $sess2 + $sess3)/3;
					$total = $_POST['total'];
					$att = $_POST['att'];
					if(!isset($_POST['pracviva']))
						{
							$pracviva = 0;
						}
					else
						{
							$pracviva = $_POST['pracviva'];
						}
					$targetspi = $_POST['targetspi'];
					if($total == 150)
						{
							if($targetspi == 6)
								{
									$min_range = 67;
									$max_range = 81;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 7)
								{
									$min_range = 82;
									$max_range = 96;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 8)
								{
									$min_range = 97;
									$max_range = 112;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 9)
								{
									$min_range = 113;
									$max_range = 125;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 10)
								{
									$min_range = 126;
									$max_range = $total;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
						}
					else if($total == 100)
						{
							if($targetspi == 6)
								{
									$min_range = 45;
									$max_range = 54;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 7)
								{
									$min_range = 55;
									$max_range = 64;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 8)
								{
									$min_range = 65;
									$max_range = 74;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 9)
								{
									$min_range = 75;
									$max_range = 84;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
							else if($targetspi == 10)
								{
									$min_range = 85;
									$max_range = $total;
									$min_ext = $min_range - ($avg + $att + $pracviva);
									$max_ext = $max_range - ($avg + $att + $pracviva);
								}
						}
					if($min_ext > 60)
						{
							$min_ext = 60;
						}
					if($max_ext > 60)
						{
							$max_ext = 60;
						}
					if($min_ext < 0)
						{
							$min_ext = 0;
						}
					if($max_ext < 0)
						{
							$max_ext = 0;
						}
				echo "<h3>Result</h3>";
				echo "<ul>";
				echo "<li>Average Sessional Marks  : ".$avg."</li>";
				echo "<li>Practical+Viva Marks  : ".$pracviva."</li>";
				echo "<li>Attendance Marks  : ".$att."</li>";
				echo "<li>Total Marks  : ".$total."</li>";
				echo "<li><b><u>External Marks Range (Predicted): ".$min_ext." To ".$max_ext."</u></b></li>";
				echo "</ul>";
				}
		 ?>
		 </div>
      </main>
</div>
<script type = "text/javascript">
function changeVal(data)
{
	if(data.value == '100')
		{
			document.getElementById("pracviva").value = 0;
			document.getElementById("pracviva").setAttribute("disabled",true);
		}
	else if(data.value == '150')
		{
			document.getElementById("pracviva").value = "";
			document.getElementById("pracviva").disabled = false;
		}
}
</script>
</body>
</html>
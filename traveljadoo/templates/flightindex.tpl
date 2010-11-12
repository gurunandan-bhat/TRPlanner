<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection" />  
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print" />  
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection" /><![endif]-->  
		<link rel="stylesheet" href="css/trains.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen" />
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<title>Explore Flights</title>
    </head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_planatrip.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="images/banners/banner_flightfinder.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<div class="prepend-2 span-8 last">
				<form method="post" action="flights.cgi">
					<fieldset>
						<legend>Find Flights Between Cities</legend>
						<p>
							<label for="src">From:</label><br />
							<select id="src" name="src">
								<option value="0">Select your Starting Point</option>
								<!-- TMPL_LOOP NAME=AIRPORTS -->
									<option value="<!-- TMPL_VAR NAME=AIRPORTCODE -->"><!-- TMPL_VAR NAME=AIRPORTNAME --></option>
								<!-- /TMPL_LOOP -->
							</select>
						</p>
						<p>
							<label for="dest">To:</label><br />
							<select id="dest" name="dest">
								<option value="0">Select your Destination</option>
								<!-- TMPL_LOOP NAME=AIRPORTS -->
									<option value="<!-- TMPL_VAR NAME=AIRPORTCODE -->"><!-- TMPL_VAR NAME=AIRPORTNAME --></option>
								<!-- /TMPL_LOOP -->
							</select>
						</p>
						<p>
							<input type="submit" name="findflights" value="Get Flights" />
						</p>
						<input type="hidden" name="mode" value="findflights" />
					</fieldset>
				</form>
			</div>
			<hr />
			<!-- TMPL_IF NAME=SUBMITTED -->
			<div class="span-14 append-5 prepend-5">
			<!-- TMPL_IF NAME=FLIGHTS -->
				<h1>Flights from <!-- TMPL_VAR NAME=SRCNAME --> to <!-- TMPL_VAR NAME=DESTNAME --></h1>
				<table width="100%">
					<tr><th>Flight No.</th><th>Operates On</th><th>Departure</th><th>Duration</th></tr>
					<!-- TMPL_LOOP NAME=FLIGHTS -->
					<tr>
						<th><!-- TMPL_VAR NAME=flightno --></th>
						<th><!-- TMPL_VAR NAME=operateson --></th>
						<th><!-- TMPL_VAR NAME=departure --></th>
						<th><!-- TMPL_VAR NAME=duration --></th>
					</tr>
					<!-- /TMPL_LOOP -->
				</table>
			<!-- TMPL_ELSE -->
			<p>
				Sorry - There are no Direct Flights between <!-- TMPL_VAR NAME=SRCNAME --> to <!-- TMPL_VAR NAME=DESTNAME -->. 
				Use our <a href="routefinder.cgi">Smart Route Finder</a> to see Routes that go via other cites
			</p>
			<!-- /TMPL_IF -->
			</div>
			<!-- /TMPL_IF -->	
		</div>
		<div class="container">
			<div class="span-24 last">
				<div id="footer">
					<!-- TMPL_INCLUDE NAME=footer.tpl -->
				</div>
			</div>
        </div>
	</body>
</html>

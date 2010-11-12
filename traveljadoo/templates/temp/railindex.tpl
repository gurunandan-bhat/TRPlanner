<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection" />  
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print" />  
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection" /><![endif]-->  
		<link rel="stylesheet" href="css/trains.css" type="text/css" media="screen" />
		<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="js/trains.js"></script>
		<title>Explore Trains</title>
    </head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="prepend-2 span-8 last">
				<form method="post" action="rail.cgi">
					<fieldset>
						<legend>Find Trains Traveling between Stations</legend>
						<p>
							<label for="src">From:</label><br />
							<select id="src" name="src">
								<option value="0">Select your Starting Point</option>
								<!-- TMPL_LOOP NAME=STATIONS -->
									<option value="<!-- TMPL_VAR NAME=STATIONCODE -->"><!-- TMPL_VAR NAME=STATIONNAME --></option>
								<!-- /TMPL_LOOP -->
							</select>
						</p>
						<p>
							<label for="dest">To:</label><br />
							<select id="dest" name="dest">
								<option value="0">Select your Destination</option>
								<!-- TMPL_LOOP NAME=STATIONS -->
									<option value="<!-- TMPL_VAR NAME=STATIONCODE -->"><!-- TMPL_VAR NAME=STATIONNAME --></option>
								<!-- /TMPL_LOOP -->
							</select>
						</p>
						<p>
							<input type="submit" name="findtrains" value="Get Trains" />
						</p>
						<input type="hidden" name="mode" value="findtrains" />
					</fieldset>
				</form>
			</div>
			<hr />
			<div class="span-10 append-4">
				<h1>Trains from <!-- TMPL_VAR NAME=SOURCE --> to <!-- TMPL_VAR NAME=DESTINATION --></h1>
				<form id="trainslist" method="get" action="#">
					<table>
						<thead><tr>
							<th></th><th>Code</th><th>Train</th><th>Dep.</th><th>Arr.</th><th>Runs On</th>
						</tr></thead>
						<!-- TMPL_LOOP NAME=ROUTES -->
						<tr<!-- TMPL_UNLESS NAME=__odd__ --> class="even"<!-- /TMPL_UNLESS -->>
							<td><input type="radio" id="<!-- TMPL_VAR NAME=shortname -->" name="shortname" value="<!-- TMPL_VAR NAME=shortname -->" <!-- TMPL_IF NAME=__first__ -->checked="checked"<!-- /TMPL_IF --> /></td>
							<td><!-- TMPL_VAR NAME=shortname --></td>
							<td><!-- TMPL_VAR NAME=longname --></td>
							<td><!-- TMPL_VAR NAME=departure --></td>
							<td><!-- TMPL_VAR NAME=arrival --></td>
							<td><!-- TMPL_VAR NAME=runson --></td>
						</tr>
						<!-- /TMPL_LOOP -->
					</table>
				</form>
			</div>
			<div class="span-10 last">
				<p id="schedulethrobber">Please wait. Getting Schedule...</p>
				<div id="detailschedule">
					<h1>Schedule: <!-- TMPL_VAR NAME=TRAINCODE --> <!-- TMPL_VAR NAME=TRAINNAME --></h1>
					<table>
						<thead><tr>
							<th>Stop</th><th>Station</th><th>Arr.</th><th>Dep.</th><th>Day</th><th>Distance</th>
						</tr></thead>
						<!-- TMPL_LOOP NAME=STOPS -->
						<tr<!-- TMPL_UNLESS NAME=__odd__ --> class="even"<!-- /TMPL_UNLESS -->>
							<td><!-- TMPL_VAR NAME=STOPNUM --></td>
							<td><!-- TMPL_VAR NAME=STOPNAME --></td>
							<td><!-- TMPL_VAR NAME=STOPARR --></td>
							<td><!-- TMPL_VAR NAME=STOPDEP --></td>
							<td><!-- TMPL_VAR NAME=STOPDAYNUM --></td>
							<td><!-- TMPL_VAR NAME=STOPDISTANCE --></td>
						</tr>
						<!-- /TMPL_LOOP -->
					</table>
				</div>
			</div>
		</div>
	</boody>
</html>

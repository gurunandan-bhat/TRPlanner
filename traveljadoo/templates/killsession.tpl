<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<title>Odyssey: Itinerary Log</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="column span-24 last city">
				<div class="column span-16">
					<div id="slideshow" class="mainimg">
						<img src="images/dalailama.jpg" width="600" height="370" alt="Errors are Fun, No?" />
					</div>
					<!-- TMPL_IF NAME=NOTCLEAN -->
					<div class="ticketslist">
						<h2>Travel Arrangements</h2>
						<table width="100%">
							<tr><th>From</th><th>To</th><th>Mode</th><th>Departure</th><th>Arrival</th></tr>
							<!-- TMPL_LOOP NAME=TICKETS -->
							<tr>
								<td><!-- TMPL_VAR NAME=FROM --></td>
								<td><!-- TMPL_VAR NAME=TO --></td>
								<td><!-- TMPL_VAR NAME=MODE --></td>
								<td><!-- TMPL_VAR NAME=DEP --></td>
								<td><!-- TMPL_VAR NAME=ARR --></td>
							</tr>
							<!-- /TMPL_LOOP -->
						</table>
					</div>
					<!-- /TMPL_IF -->
				</div>
				<div class="column span-8 last description">
					<!-- TMPL_IF NAME=NOTCLEAN -->
					<h1>You have exceeded your Karma Points.</h1>
					<h2>That means no more Girls!!</h2>
					<p>Sorry, you have several unaccounted actions left for you to perform in this cycle of birth and death. You have no choice but to keep traveling.
					If you want a second chance Click "Cleanse Me" and you can start traveling again afresh.<br /><br /> 
					Nirvana must wait for another day.</p>
					<p>
					<form method="post" action="index.cgi">
						<input type="hidden" name="mode" value="restart" />
						<input type="submit" name="nirvana" value="Cleanse Me!" />
					</form>
					</p>
					<p class="error">
						<!-- TMPL_VAR NAME=DUMP -->
					</p>
					<hr />
					<h2>City Schedule</h2>
					<table width="100%">
						<tr><th>Id</th><th>Name</th><th>Arrival</th><th>Departure</th></tr>
						<!-- TMPL_LOOP NAME=CITYSTOPS -->
						<tr>
							<td><!-- TMPL_VAR NAME=CITYID --></td>
							<td><!-- TMPL_VAR NAME=CITYNAME --></td>
							<td><!-- TMPL_VAR NAME=DATEIN --></td>
							<td><!-- TMPL_VAR NAME=DATEOUT --></td>
						</tr>
						<!-- /TMPL_LOOP -->
					</table>
					<h2>Hotel Schedule</h2>
					<table width="100%">
						<tr><th>Id</th><th>Name</th><th>Nights</th></tr>
						<!-- TMPL_LOOP NAME=HOTELS -->
						<tr>
							<td><!-- TMPL_VAR NAME=HOTELID --></td>
							<td><a href="hotel.cgi?id=<!-- TMPL_VAR NAME=HOTELID -->" target="_blank"><!-- TMPL_VAR NAME=HOTELNAME --></a></td>
							<td><!-- TMPL_VAR NAME=HOTELNIGHTS --></td>
						</tr>
						<!-- /TMPL_LOOP -->
					</table>
					<!-- TMPL_ELSE -->
					<h1>You have Nirvana!.</h1>
					<p>The cycle of birth and death is over. Rejoice. You are clean and ready to go. Click "Restart" to continue</p>
					<form method="get" action="index.cgi">
						<input type="submit" name="nirvana" value="Restart!" />
					</form>
					<!-- /TMPL_IF -->
				</div>
			</div>
		</div>
	</body>
</html>

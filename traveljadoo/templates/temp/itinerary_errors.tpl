<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<title>Odyssey Tours and Travels: Home</title>
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
					<div id="slideshow" class="mainimg" thishotel="<!-- TMPL_VAR NAME=HOTELID -->" maxhotelimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="images/index_main.jpg" width="600" height="370" alt="1" />
					</div>
				</div>
				<div class="column span-8 last description">
					<h1>Your Magical Itinerary!</h1>
					<p>We have generated your Itinerary. The first table shows the Summary of your day-to-day schedule. The following table
					gives details about each stop, sightseeing that we have planned and a short note on what makes each stop of your
					tour special.</p>
					<h1>Welcome to India!</h1>
				</div>

			</div>
			<div class="span-5 chatter">
				<div style="margin-top: 15px;">
				<p><a href="#">Register</a></p>
			  	<p><a href="#">Need Help</a>?<br />Many Questions are already answered in our <a href="#">FAQs</a>, 
			  		otherwise, <a mailto="hans@odyssey.co.in">email us</a> here
				</p>
				</div>
			</div>
			<div class="span-14 append-5 last">
				<h1 style="margin-top: 20px;">Itinerary Summary</h1>
				<table>
					<tr><th>Day-to-Day Itinerary</th></tr>
					<!-- TMPL_LOOP NAME=SUMMARY -->
					<tr>
						<td><h2>Day <!-- TMPL_VAR NAME=DAYNUM -->: <!-- TMPL_VAR NAME=DATE --> <!-- TMPL_VAR NAME=CITY --></h2><!-- TMPL_VAR NAME=DETAIL --></td>
					</tr>
					<!-- /TMPL_LOOP -->
				</table>
			</div>
			<div class="span-14 prepend-5 append-5 last">
				<h1 style="margin-top: 10px;">Detailed Itinerary</h1>
				<table>
					<tr><th>Milestones in your Journey</th></tr>
					<!-- TMPL_LOOP NAME=DETAILS -->
					<tr>
						<td><h1>Day <!-- TMPL_VAR NAME=DAYNUM -->: <!-- TMPL_VAR NAME=HEADER --></h1><h2><!-- TMPL_VAR NAME=DATE --> <!-- TMPL_VAR NAME=CITY --></h2><!-- TMPL_VAR NAME=DETAIL --></td>
					</tr>
					<!-- /TMPL_LOOP -->
				</table>
			</div>
		</div>
	</body>
</html>

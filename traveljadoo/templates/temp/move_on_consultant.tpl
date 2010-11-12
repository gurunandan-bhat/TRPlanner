<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection">
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAANNgAl6Yk0J_LHL8ee--iiBRKRT3lEAXbWt9bKSuE5xGrJNjhaBSmYrPob9NYNAyq2W3hgzWgqsVk9g" type="text/javascript">
		</script>
		<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="js/jquery.cycle.pack.js"></script>
		<script type="text/javascript" src="js/odyssey.js"></script>
		<title>Odyssey Tours: <!-- TMPL_VAR NAME=CURRNAME --></title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
					<p><a href="<!-- TMPL_VAR NAME=OLDLINK -->">Click here to view old template</a></p>
				</div>
			</div>
			<div class="column span-24 last city">
				<div class="column span-16 main_consultant">
					<div style="padding-left: 20px;">
					<!-- TMPL_IF NAME=SUMMARY -->
						<div class="topcity">
							<h1>Our Recommended Next Destination: <!-- TMPL_VAR NAME=DEFAULTCITYNAME --></a></h1>
							<p><img class="status" src="images/city_<!-- TMPL_VAR NAME=DEFAULTCITYID -->_movingon.jpg" width="240" height="150" alt="<!-- TMPL_VAR NAME=NAME -->" /> 
							<!-- TMPL_VAR NAME=DEFAULTCITYWRITEUP --></p>
						</div>
						<hr />
						<h1><!-- TMPL_VAR NAME=PAXNAME -->'s Custom Tour Plan</h1>
						<!-- TMPL_VAR NAME=SUMMARY -->
					<!-- TMPL_ELSE -->
						<h1>Welcome Gentle Traveler</h1>
						<p>We have no record of your Tour. To build your tour, we first need some information. <a href="index.cgi?mode=init">Click here</a> to start planning tour".</p>
					<!-- /TMPL_IF -->
					<h1>View Destinations in your Itinerary on our Map</h1>
					<img class="status" src="images/tour_status.jpg" width="600" />
					</div>
				</div>
				<div class="column span-8 last description">
					<!-- TMPL_IF NAME=SUMMARY -->
						<div class="moveon">
							<h1>Interesting Places to go to from <!-- TMPL_VAR NAME=CURRNAME --></h1>
							<div class="option">
								<ul>
								<!-- TMPL_LOOP NAME=NEARCITIES -->					
									<li>
										<a href="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=ID -->"><!-- TMPL_VAR NAME=NAME --></a>.
										<!-- TMPL_VAR NAME=ONLINER -->
									</li>
								<!-- /TMPL_LOOP -->
								</ul>
							</div>
							<div class="option">					
								<h1>Choose your next stop from a List</h1>
								<form class="nextcity" method="post" action="travel.cgi">
									<p><label for="desturl"></label> 
										<select id="desturl" name="desturl">
										<!-- TMPL_LOOP NAME=RANDOMDESTINATION -->
											<option value="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=RANDOMDESTID -->"><!-- TMPL_VAR NAME=RANDOMDESTNAME --></option>
										<!-- /TMPL_LOOP -->
										</select>
										<input type="submit" value="Go!" />
										<input type="hidden" name="mode" value="randomcity" />
									</p>
								</form>
								<h1>Or, use the Map!</h1>
								<div id="map_canvas" lat="<!-- TMPL_VAR NAME=LATITUDE -->" lng="<!-- TMPL_VAR NAME=LONGITUDE -->"></div>	
							</div>
							<h1>Want to end your tour?</h1>
							<p><a href="travel.cgi?mode=end_tour">Yes! End my tour now at <!-- TMPL_VAR NAME=CURRNAME --></a></p>
						</div>
					<!-- /TMPL_IF -->
				</div>
			</div>
		</div>
	</body>
</html>

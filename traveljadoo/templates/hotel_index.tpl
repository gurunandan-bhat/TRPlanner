<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/hotelsearch.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<title>Odyssey: Hotels of India</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_splaces.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/specialplaces_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a src="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a src="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li> &raquo; Special Places</li>
						<li><a src="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a src="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a src="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a src="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>Special Places</h3>
					<p>Want to plan your own trip but you don't know where to start?</p>
					<p>Take a quick look at our Special Places for some inspiration to help you on your way. We have listed our favourite small hotels, 
					guesthouses, retreats, eco-lodges and heritage hotels. They are all unique - either for the location, the history of the building, 
					the ambience, or the family who runs the hotel.
	        		</p>
					<div>
						<form id="bighotelssearch" method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel.cgi">
							<fieldset>
								<legend>Search our Database by City, State or part of a Name</legend>
								<label for "state">Find Hotels in a State:</label>
								<select id="state" class="bystate" name="id" size="1">
									<option value="0" selected="selected">Choose a State...</option>
									<!-- TMPL_LOOP NAME=STATES -->
										<option value="<!-- TMPL_VAR NAME=STATEID -->"><!-- TMPL_VAR NAME=STATE --></option>
									<!-- /TMPL_LOOP -->
								</select><br /><br />
								<label for "city">Find Hotels in a  City:</label>
								<select id="city" class="bycity" name="id" size="1">
									<option value="0" selected="selected">Choose a City...</option>
									<!-- TMPL_LOOP NAME=CITIES -->
										<option value="<!-- TMPL_VAR NAME=CITYID -->"><!-- TMPL_VAR NAME=CITY --></option>
									<!-- /TMPL_LOOP -->
								</select><br /><br />
								<label for="byname">Search a Hotel by Name: </label>
								<input type="text" id="byname" name="hotelname" />
								<input type="submit" name="textsearch" value="Search!" />
								<input type="hidden" name="mode" value="namesearch" />
							</fieldset>
						</form>
					</div>
	         		<p>After browsing through our list of Special Places, we offer the opportunity to create your own personal unique independent itinerary in India 
					online. In <a href="index.cgi?mode=init">Plan a Trip</a> you simply select the places you wish to visit and your preferred mode of transport. Our 
					Travel Wizard then creates a 
					suggested itinerary with a costing. You are able to amend the proposed itinerary to arrive at a program of your choice.</p>
					<p>You can also use our diverse range of <a href="itineraries.cgi">Modules</a> as a guideline. The featured tours follow a logical route and move at a leisurely pace and 
					give you a good insight into the particular area. Our Travel Wizard allows you to modify the selected itinerary so that you can create your own unique 
					holiday by combining our ideas with your preferences.</p>
				</div>
				<div class="span-8 rightcol last">
					<h3>Plan the Perfect Trip</h3>
					<p class="box"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/plantheperfecttrip.gif" width="125" height="116" /> In easy to follow steps, you can build your own custom-made itinerary in our unique Trip Planner. Planning a trip to India has never been so easy!</p>
					<h3>Train Finder</h3>
					<p class="box"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/trainfinder.jpg" width="125" height="90" /> Looking for the best train connection? Our innovative Train Finder provides the most powerful search engine for the vast Indian Railways system.</p>
					<h3>Flight Finder</h3>
					<p class="box"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/flightfinder.jpg" width="125" height="90" /> Traveller's Palm presents the fastest Flight Finder in India. Tell us your starting point and destination and we will give you the most convenient flight plan.</p>
					<h3>Smart Route Finder</h3>
					<p class="box"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/smartroutefinder.jpg" width="125" height="90" /> Traveller's Palm's  firecracker is the Smart Route Finder, an astonishing tool that tells you how to travel from A to B in the best combination of trains, drives and flights!</p> 
					<hr />
				</div>
			</div>
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

			
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/tpalm.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="js/hotelsearch.js"></script>
		<title>Odyssey: Hotels of India</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="span-24 broadbanner last">
				<img src="images/main_banner3.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr style="color: #fff; background: #fff; margin-bottom: 3px;" />
			<div class="span-8">
				<div class="box">
					<img src="images/menu1.jpg" height="70" width="110" />
					<h1>Special Places</h1>
					<p>Browse places of interest and view details of our <strong>hand-picked accommodation</strong>.</p>
				</div>
			</div>
			<div class="span-8">
				<div class="box">
					<img src="images/menu2.jpg" height="70" width="110" />
					<h1>Journey Ideas</h1>
					<p>Check out our <strong>suggested itineraries</strong> to get inspiration for planning your own trip.</p>
				</div>
			</div>
			<div class="span-8 last">
				<div class="box">
					<img src="images/menu3.jpg" height="70" width="110" />
					<h1>Trip Planner</h1>
					<p>Use our ineractive Travel Wizard, to <strong>design your own tour</strong>!</p>
				</div>
			</div>
			<div class="span-24 content last">
				<div class="span-4 leftmost">
					<div style="margin-left:10px">
						<h1 class="columns">Home</h1>
						<p>
							100% Tailor-made<br />
							Specialist knowledge<br />
							Responsible travel<br />
							What you can expect<br />
							When to Go
						</p>
						<h1 class="columns">Special Places</h1>
						<p>
							Introduction<br />
							Regions<br />
							Cities<br />
							Hotels
						</p>
						<h1 class="columns">Journey Ideas</h1>
						<p>
							Itineraries<br />
							Highlights<br />
							Themes<br />
							Features
						</p>
						<h1 class="columns">Trip Planner</h1>
						<p>
							Creating your tour<br />
							Train Finder <br />
							Flight Finder <br />
							Smart Route Finder
						</p>
						<h1 class="columns">About Us</h1>
						<p>
							Traveller's Palm<br />
							Our team<br />
							Privacy policy<br />
							Terms of use<br />
							Contact us
						</p>
					</div>
				</div>
				<div class="span-12 itinerary">
					<h1 class="columns">Special Places</h1>
					<p>Want to plan your own trip but you don't know where to start?</p>
					<p>Take a quick look at our Special Places for some inspiration to help you on your way. We have listed our favourite small hotels, 
					guesthouses, retreats, eco-lodges and heritage hotels. They are all unique - either for the location, the history of the building, 
					the ambience, or the family who runs the hotel.
	        		</p>
					<div>
						<form id="bighotelssearch" method="post" action="hotel.cgi">
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
					<p>You can also use our diverse range of <a href="index.cgi?mode=itineraries">Itineraries</a> as a guideline. The featured tours follow a logical route and move at a leisurely pace and 
					give you a good insight into the particular area. Our Travel Wizard allows you to modify the selected itinerary so that you can create your own unique 
					holiday by combining our ideas with your preferences.</p>
				</div>
				<div class="span-8 last">
					<h1 class="columns">Our Columnists</h1>
					<div class="summary">
						<h1>The Flying Dutchman Chronicles</h1>
						<img src="images/HANS02.jpg" width="120" height="75" alt="Hans Tuinman" />
						<h2>Joy of the Rains</h2>
						<h3>Tue, June 2, 2009 18:34</h3>
						<p>Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one 
						 consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical 
						literature, discovered the undoubtable source. <a href="#">Read More ...</a></p>
					</div>
					<div class="summary">
						<h1>Dances with AB</h1>
						<img src="images/SUCHETA01.jpg" width="120" height="75" alt="Hans Tuinman" />
						<h2>Sands of Rajasthan</h2>
						<h3>Wed, July 4, 2009 18:34</h3>
						<p>Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one 
						 consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical 
						literature, discovered the undoubtable source. <a href="#">Read More ...</a></p>
					</div>
					<div class="summary">
						<h1>The Queens Voice</h1>
						<img src="images/PHIL01.jpg" width="120" height="75" alt="Hans Tuinman" />
						<h2>Bend it like Phil</h2>
						<h3>Fr, July 7, 2009 12:07</h3>
						<p>Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one 
						 consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical 
						literature, discovered the undoubtable source. <a href="#">Read More ...</a></p>
					</div>
				</div>
			</div>			
		</div>
		<div class="container footer">
			<div class="span-24 last">
				<h1 class="columns">Footer</h1>
				<div class="prepend-1 span-7 colborder">
					<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of 
					classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin 
					professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, 
					consectetur, from a Lorem Ipsum passage, and going through the citeis of the word in classical 
					literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 
					of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC.</p>
				</div>
				<div class="span-7 colborder">
					<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of 
					classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin 
					professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, 
					consectetur, from a Lorem Ipsum passage, and going through the citeis of the word in classical 
					literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 
					of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC.</p>
				</div>
				<div class="span-6 append-1 last">
					<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of 
					classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin 
					professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, 
					consectetur, from a Lorem Ipsum passage, and going through the citeis of the word in classical 
					literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 
					of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC.</p>
				</div>
			</div>
        </div>
	</body>
</html>

			
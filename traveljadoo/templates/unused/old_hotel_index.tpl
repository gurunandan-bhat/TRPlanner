<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="js/hotelsearch.js"></script>
		<title>Odyssey: Hotels of India</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
					<!-- TMPL_INCLUDE NAME="hotel_searchform.tpl" -->				
				</div>
			</div>
			<div class="span-24 broadbanner">
				<img src="images/main_banner3.jpg" width="950" height="150" alt="Collage"/>
				<hr class="bigspacer" />
			</div>
			<div class="span-5 chatter">
				<h1><a href="hotel.cgi?mode=why">How we Select Hotels</a></h1>
				<p>A brief description of our criteria for selecting a place as special</p>
				<p><a href="#">Register</a></p>
			  	<p><a href="#">Need Help</a>?<br />Many Questions are already answered in our <a href="#">FAQs</a>, 
			  		otherwise, <a mailto="hans@odyssey.co.in">email us</a> here
				</p>
			</div>
			<div class="span-12 append 7">
				<h1>Special Places</h1>
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
		</div>
	</body>
</html>

			
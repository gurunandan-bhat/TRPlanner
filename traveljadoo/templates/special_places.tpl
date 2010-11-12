<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/hotelsearch.js"></script>
		<script type="text/javascript" src="js/state.js"></script>
		<script type="text/javascript" src="js/swfobject.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<title>Special Places to Stay – Independent India Travel | Traveller's Palm</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_splaces.tpl" -->
			</div>
			<div class="span-11 frame">
				<div class="box">
					<div id="flashcontent" style="width: 410px; height: 500px;"></div>
				</div>
			</div>
			<div class="span-4 content-2">
				<h3>Cities</h3>
				<p>Use the map alongside browse States and click a region to view Cities in that State.</p>
				<div id="details"></div>
			</div>
			<div class="span-9 content-2 last">
				<h3>Special Places</h3>
				<div class="box">
					<p>Want to plan your own trip but you don't know where to start?</p>
					<p>Take a quick look at our Special Places for some inspiration to help you on your way. We have listed our favourite small hotels, 
					guesthouses, retreats, eco-lodges and heritage hotels. They are all unique - either for the location, the history of the building, 
					the ambience, or the family who runs the hotel.
	        		</p>
					<div>
						<form id="bighotelssearch" method="post" action="hotel.cgi">
							<fieldset>
								<legend>Browse States, Cities or Hotels</legend>
								<label for "state">Browse States:</label>
								<select id="state" class="bystate" name="id" size="1">
									<option value="0" selected="selected">Choose a State...</option>
									<!-- TMPL_LOOP NAME=STATES -->
										<option value="<!-- TMPL_VAR NAME=STATEID -->"><!-- TMPL_VAR NAME=STATE --></option>
									<!-- /TMPL_LOOP -->
								</select><br /><br />
								<label for "city">Browse Cities:</label>
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
			</div>
			<hr class="space">
		</div>
		<div class="container">
			<div class="span-24 last">
				<div id="footer">
					<!-- TMPL_INCLUDE NAME=footer.tpl -->
				</div>
			</div>
        </div>
		<script type="text/javascript">
		// <![CDATA[		
			var so = new SWFObject("maps/ammap.swf", "ammap", "100%", "100%", "8", "#ffffff");
    		so.addVariable("path", "maps/");
			so.addVariable("data_file", escape("maps/ammap_data.xml"));
    		so.addVariable("settings_file", escape("maps/ammap_settings.xml"));		
			so.addVariable("preloader_color", "#999999");
			so.write("flashcontent");
		// ]]>
		</script>
	</body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/cmxform.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/quoteform-validate.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>

		<title>Odyssey: About Us</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
				<!-- TMPL_IF NAME=FROMTOUR -->
					<!-- TMPL_INCLUDE NAME="bannermenu_tours.tpl" -->
				<!-- TMPL_ELSE -->
					<!-- TMPL_INCLUDE NAME="bannermenu_modules.tpl" -->
				<!-- /TMPL_IF -->										
				</div>
			</div>
			<div class="span-24 last">
				<img src="images/banners/banner_requestaquote.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>Request a Quote</h3>
					<p>Here are the items you have added to your Favourites.</p>
					<p>
						If you wish to send any (or all) of these to us as part of an enquiry about a trip, simply select 
						the Mini Itineraries and/or Indian Journeys that you're interested in and they will be added to the 
						enquiry form.
					</p>
					<p>Once we receive your enquiry, one of our specialists will contact you to discuss your requirements in more detail.</p>
					<p>
						<em>Making an enquiry does not put you under any obligation to make a booking.</em>
					</p>
					<form action="/confirm-quotation" class="cmxform" method="post" id="quoteform">
						<h4>Mini Itineraries</h4>
						<!-- TMPL_IF NAME=ITINBASKET -->
						<p>
							You can create your own individual travel plan by combining a number of Mini Itineraries. <br />
							Please tick the Mini Itineraries you would like to finally select:
 						</p>
						<div id="listofmods">
						<fieldset>
							<legend>Your saved Mini Itineraries</legend>
							<ol>
								<!-- TMPL_LOOP NAME=ITINBASKET -->
								<li>
									<label for="bq_<!-- TMPL_VAR NAME=ID -->">
										<input id="bq_<!-- TMPL_VAR NAME=ID -->" name ="modules" value="<!-- TMPL_VAR NAME=ID -->" type="checkbox" />
										<!-- TMPL_VAR NAME=NAME -->
									</label><br />
									Duration: <!-- TMPL_VAR NAME=DURATION -->;<br />Cost; <!-- TMPL_VAR NAME=COST -->
								</li>
								<!-- /TMPL_LOOP -->
							</ol>
						</fieldset>
						</div>
						<!-- TMPL_ELSE -->
						<p>No Mini Itineraries Saved.</p>
						<!-- /TMPL_IF --> 
						<p>
							Please feel free to browse more <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a>. You can keep adding to 
							your favourites and you can come back here when you are done.
						</p>
						<h4>Indian Journeys</h4>
						<p>
							Alternatively (or in addition), you can select one or more "Indian Journeys".<br />
							Please tick the journies you would like to select
						</p>
						<!-- TMPL_IF NAME=RTOURBASKET -->
						<fieldset>
							<legend>Your saved Journeys</legend>
							<div id="listoftours">
								<ol>
									<!-- TMPL_LOOP NAME=RTOURBASKET -->
									<li>
										<label for="bq_<!-- TMPL_VAR NAME=ID -->">
											<input id="bq_<!-- TMPL_VAR NAME=ID -->" name = "readytours" value="<!-- TMPL_VAR NAME=ID -->" type="checkbox" />
											<!-- TMPL_VAR NAME=NAME -->
										</label><br />
										Duration: <!-- TMPL_VAR NAME=DURATION -->;<br />Cost; <!-- TMPL_VAR NAME=COST -->
									</li>
									<!-- /TMPL_LOOP -->
								</ol>
							</div>
						</fieldset>
						<!-- TMPL_ELSE -->
						<p>No Indian Journeys Saved.</p>
						<!-- /TMPL_IF --> 
						<p>
							Please feel free to browse more <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a>. You can keep adding to your basket 
							and you can come back here when you are done.
						</p>
						<fieldset>
							<legend>Special Requests</legend>
							<p>Please add any special requests, cities or hotels that you would like to be included in your program.</p>
							<ol>
								<li><label for="sprequest" style="-moz-inline-box">Request: <textarea id="sprequest" cols="25" rows="7" name="sprequest"></textarea></label></li>
							</ol>
						</fieldset>
						<input type="hidden" name="mode" value="quotation_details" />
						<p><input type="submit" id="quote-submit" value="Proceed with my Quote Request" /></p>
						<p>Click here to return to <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a> or <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a>.</p>
					</form>
				</div>
				<div class="span-8 rightcol last">
					<h3>Your Favourites</h3>
					<div class="box">
						<h5>Mini Itineraries</h5>
						<ol>
							<!-- TMPL_LOOP NAME=ITINS -->
							<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->moduledetails/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ol>
						<h5>Indian Journeys</h5>
						<ol>
							<!-- TMPL_LOOP NAME=RTOURS -->
							<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ol>
						<h5>Cities</h5>
						<ol>
							<!-- TMPL_LOOP NAME=CITIES -->
							<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->city/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ol>
						<h5>Hotels</h5>
						<ol>
							<!-- TMPL_LOOP NAME=HOTELS -->
							<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ol>
					</div>
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

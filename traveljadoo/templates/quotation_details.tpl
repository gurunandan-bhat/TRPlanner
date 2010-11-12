<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/cmxform.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.validate.pack.js"></script>
		<script type="text/javascript" src="js/quoteformdetails-validate.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<title>Odyssey: About Us</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_splaces.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="images/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="/">Home</li>
						<li><a href="/themes">Themes</a></li>
						<li><a href="/special_places">Special Places</a></li>
						<li><a href="/modules">Modules</a></li>
						<li><a href="/tours">Tours</a></li>
						<li><a href="/about-us">Tours</a></li>
						<li><a href="/contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>A Few Details to help us Quote</h3>
					<p>
						<em>Remember: Making an enquiry does not put you under any obligation to make a booking.</em>
					</p>
					<form action="/acknowledge-quotation" id="quoteformdetails" class="cmxform" method="post">
						<p>
							You have selected the following Modules and Ready Tours:
 						</p>
						<ol>
							<!-- TMPL_LOOP NAME=ITEMS -->
							<li><strong><!-- TMPL_VAR NAME=ITEMNAME --></strong></li>
							<input type="hidden" name="items" value="<!-- TMPL_VAR NAME=ITEMID -->" />
							<!-- /TMPL_LOOP -->
						</ol>
						<!-- TMPL_IF NAME=REQUEST -->
						<p>
							You have requested the following:<br><strong><!-- TMPL_VAR NAME=REQUEST --></strong>
						</p>
						<!-- /TMPL_IF -->
						<input type="hidden" name="request" value="<!-- TMPL_VAR NAME=REQUEST -->" />
						<h4>Your Travel Details</h4>
						<fieldset>
							<legend>Details about your Party</legend>
							<ol>
								<li>
									<label for="leadname" class="short">Lead Name (i.e your name):</label>
									<input type="text" class="required" id="leadname" name="leadname" />
								</li>
								<li>
									<label for="pax" class="short">Number of Travellers: </label>
									<select class="smallwidth" id="pax" name="pax" size="1">
										<option value="0">0</option>
										<option value="1">1</option>
										<option value="2" selected="selected">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
									</select>
								</li>
							</ol>
						</fieldset>
						<fieldset>
							<legend>Your Hotel and Room Preferences</legend>
							<ol>
								<li>
									<label for="single" class="short">Single Room(s): </label>
									<select class="smallwidth" id="single" name="single" size="1">
										<option value="0" selected="selected">0</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</li>
								<li>
									<label for="double" class="short">Double Room(s) <span style="font-style: italic;">(with a large bed)</span>: </label>
									<select class="smallwidth" id="double" name="double" size="1">
										<option value="0">0</option>
										<option value="1" selected="selected">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</li>
								<li>
									<label for="twin" class="short">Double Room(s) <span style="font-style: italic">(with two beds)</span>: </label>
									<select class="smallwidth" id="twin" name="twin" size="1">
										<option value="0" selected="selected">0</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</li>
								<li>
									<label for="triple" class="short">Triple Room(s): </label>
									<select class="smallwidth" id="triple" name="triple" size="1">
										<option value="0" selected="selected">0</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
									</select>
								</li>
							</ol>
						</fieldset>
						<input type="hidden" name="mode" value="quote_modtours" />
						<p><input type="submit" value="Send me a Quotation" /></p>
						<p>Click here to return to <a href="/modules">Itineraries</a> or <a href="/tours">Ready Tours</a>.</p>
					</form>
				</div>
				<div class="span-8 rightcol last">
					<h3>Your Favourites</h3>
					<div class="box">
						<h5>Modules</h5>
						<ol>
							<!-- TMPL_LOOP NAME=ITINS -->
							<li><a href="/moduledetails/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ol>
						<h5>Tours</h5>
						<ol>
							<!-- TMPL_LOOP NAME=RTOURS -->
							<li><a href="/tourdetails/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ol>
						<h5>Cities</h5>
						<ol>
							<!-- TMPL_LOOP NAME=CITIES -->
							<li><a href="/city/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ol>
						<h5>Hotels</h5>
						<ol>
							<!-- TMPL_LOOP NAME=HOTELS -->
							<li><a href="/hotel/<!-- TMPL_VAR NAME=URL -->"><!-- TMPL_VAR NAME=NAME --></a></li>
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

			
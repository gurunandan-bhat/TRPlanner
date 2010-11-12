<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/jquery-ui-1.7.1.custom.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.7.1.custom.min.js"></script>
		<script type="text/javascript" src="js/intro.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<title>Odyssey: Design your own Tour</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="span-24 broadbanner">
				<img src="images/banner05.jpg" width="950" height="150"/>
			</div>
			<hr class="bigspacer"/>
			<div class="span-5 chatter">
				<p><a href="#">Register</a></p>
			  	<p><a href="#">Need Help</a>?<br />Many Questions are already answered in our <a href="#">FAQs</a>, 
			  		otherwise, <a mailto="hans@odyssey.co.in">email us</a> here
				</p>
			</div>
			<div class="span-14 append-5 last">
				<h1>Design your Own Tour!</h1>
				<p><img src="images/puzzle.jpg" width="160" height="148" style="float: right; padding-top: -10px; margin-top: -10px;" />
				We have created a unique Travel Wizard that lets you put together a customised tour online. You simply choose the places you wish to visit, 
				and select your preferred mode of transport. Our Travel Wizard then creates a suggested itinerary with a costing. You are able to amend the 
				proposed itinerary to arrive at a program of your choice.</p>
				<p>Take your time and enjoy your trip.</p>
				<div class="questions">
				  <h1>A Few Questions before we begin...</h1>
					<form method="post" action="index.cgi">
						<input type="hidden" name="mode" value="start" />
						<fieldset id="main">
							<legend>Details about your Party</legend>
							<label for="leadname">Lead Name (i.e your name):</label>
							<input type="text" id="leadname" name="leadname" /><br />
							<label for="pax">Number of Travellers: </label>
							<select id="pax" name="pax" size="1">
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
						</fieldset>
						<fieldset id="hotel">
							<legend>Your Hotel and Room Preferences</legend>
							<label for="hotelcategory">Hotel Category: </label>
							<select id="hotelcategory"  name="hotelcategory"size="1">
								<option value="5">Top of the Line</option>
								<option value="4">Luxury</option>
								<option value="3">Superior</option>
								<option value="2" selected="selected">Standard</option>
							</select>
							<br />
							<label for="single">Single Room(s): </label>
							<select id="single" name="single" size="1">
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
							<br />
							<label for="double">Double Room(s):<br /><span style="font-style: italic;">with one large bed</span></label>
							<select id="double" name="double" size="1">
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
							<br />
							<label for="twin">Double Room(s):<br /><span style="font-style: italic">with two beds</span></label>
							<select id="twin" name="twin" size="1">
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
							<br />
							<label for="triple">Triple Room(s): </label>
							<select id="triple" name="triple" size="1">
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
						</fieldset>
						
						<fieldset id="entrance">
							<legend>On-site Entrance Fees</legend>
							<input type="checkbox" id="entrance" name="entrance" checked="checked" />
							<label for="entrance">Include Entrance Fees in Cost Calculation</label>
						</fieldset>
						
						<fieldset id="arrdep">
							<legend>Your Arrival and Departure Details</legend>
							<h2>Arrival Details</h2>

							<p>Please note that most hotels in India have a check-in and check-out time of 12 noon.
							 If your flight arrival is in the early hours of the day, we therefore need to book your
							 accommodation already from the previous night. The start date of the tour may therefore
							 be one day before your flight arrival date.</p>

							<Label for="arrdate">Arrival Date: </Label>
							<input id="arrdate" name="arrdate" type="text" /><br />
							<Label for="arrtimehh">Arrival Time HH: MM</Label>
							<input id="arrtimehh" name="arrtimehh" type="text" size="2" maxlength="2"/> <input id="arrtimemm" name="arrtimemm" type="text" size="2" maxlength="2"/>
							<br />
							<label for="arrplace">Arriving In (City): </label>
							<select id="arrplace" name="arrplace" size="1">
							<!-- TMPL_LOOP NAME=CITIES -->
								<!-- TMPL_IF NAME=AIRPORT -->
									<option value="<!-- TMPL_VAR NAME=CITIES_ID -->"<!-- TMPL_IF NAME=DEFARRCITY --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=CITY --></option>
								<!-- /TMPL_IF -->
							<!-- /TMPL_LOOP -->
							</select>
							<label for="arrflt">My Arrival Flight Number (Optional): </label>
							<input id="arrflt" name="arrflt" type="text" /><br /><br />
							<hr />
							<h2>Starting City of Tour</h2>
							<p>The starting city of your may be the same city as where the airport is located or can
							be another city nearby where you would like to spend your first night. For instance, your
							flight may land in Chennai but you may want to spend the night in nearby Mamallapuram.</p>  
							
							<label for="startplace">Start Tour From (City): </label>
							<select id="startplace" name="startplace" size="1">
							<!-- TMPL_LOOP NAME=CITIES -->
								<option value="<!-- TMPL_VAR NAME=CITIES_ID -->"<!-- TMPL_IF NAME=DEFDEPCITY --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=CITY --></option>
							<!-- /TMPL_LOOP -->
							</select><br /><br />
							<hr />
							<h2>Departure</h2>
							<Label for="depdate">Departure Date: </Label>
							<input id="depdate" name="depdate" type="text" /><br />
							<label for="depplace">I am departing from: </label>
							<select id="depplace" name="depplace" size="1">
							<!-- TMPL_LOOP NAME=CITIES -->
								<!-- TMPL_IF NAME=AIRPORT -->
									<option value="<!-- TMPL_VAR NAME=CITIES_ID -->"<!-- TMPL_IF NAME=DEFDEPCITY --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=CITY --></option>
								<!-- /TMPL_IF -->
							<!-- /TMPL_LOOP -->
							</select>
							<label for="depflt">My Departure Flight Number (Optional): </label>
							<input id="depflt" name="depflt" type="text" /><br />
							<input type="hidden" name="mode" value="start" />
						</fieldset>
						<input type="submit" name="submit" value="Start my Tour!" />
					</form>
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

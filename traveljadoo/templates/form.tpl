<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/odysseyforms.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/jquery-ui-1.7.1.custom.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.7.1.custom.min.js"></script>
		<script type="text/javascript" src="js/intro.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<script type="text/javascript" src="js/jquery.validate.pack.js"></script>
		<script type="text/javascript" src="js/form-validate.js"></script>
		<title>The Traveller's Palm: Plan your Own Custom Trip!</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_planatrip.tpl" -->
			</div>
			<div class="span-24 last">
				<img src="images/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Login</h3>
					<div class="box">
						<!-- TMPL_VAR NAME=LOGINTEXT -->
						<p>Click <a href="index.cgi?mode=legal&id=16">here</a> to view our Privacy Policy</p>
					</div>
					
				</div>
				<div class="span-12 midcol">
					<h3>A Brief Set of Questions</h3>
					<form id="planatrip" method="post" action="index.cgi">
						<input type="hidden" name="mode" value="start" />
						<fieldset id="main">
							<legend>Details about your Party</legend>
							<ol>
								<li>
									<label for="leadname">Lead Name (i.e your name):</label>
									<input type="text" id="leadname" name="leadname" />
								</li>
								<li>
									<label for="pax">Number of Travellers: </label>
									<select class="smallwidth" id="pax" name="pax" size="1">
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
						<fieldset id="hotel">
							<legend>Your Hotel and Room Preferences</legend>
							<ol>
								<li>
									<label for="hotelcategory">Hotel Category: </label>
									<select id="hotelcategory"  name="hotelcategory"size="1">
										<option value="5">Top of Line</option>
										<option value="4">Luxury</option>
										<option value="3">Superior</option>
										<option value="2" selected="selected">Standard</option>
									</select>
								</li>
								<li>
									<label for="single">Single Room(s): </label>
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
									<label for="double">Double Room(s) <span style="font-style: italic;">(with a large bed)</span>: </label>
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
									<label for="twin">Double Room(s) <span style="font-style: italic">(with two beds)</span>: </label>
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
									<label for="triple">Triple Room(s): </label>
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
						<fieldset id="arrdep">
							<legend>Your Arrival and Departure Details</legend>
							<h2>Arrival Details</h2>
							<p>Please note that most hotels in India have a check-in and check-out time of 12 noon.
							 If your flight arrival is in the early hours of the day, we therefore need to book your
							 accommodation already from the previous night. The start date of the tour may therefore
							 be one day before your flight arrival date.</p>
							<ol>
								<li>
									<Label for="arrdate">Arrival Date: </Label>
									<input id="arrdate" name="arrdate" type="text" />
								</li>
								<li>
									<Label for="arrtimehh">Arrival Time HH: MM</Label>
									<select class="smallwidth" id="arrtimehh" name="arrtimehh" size="1">
										<option value="">HH</option>
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09" selected="selected">09</option>
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
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
									<select class="smallwidth" id="arrtimemm" name="arrtimemm" size="1">
										<option value="">MM</option>
										<option value="00" selected="selected">00</option>
										<option value="15">15</option>
										<option value="30">30</option>
										<option value="45">45</option>
									</select>
									
<!--									<input class="smallwidth" id="arrtimehh" name="arrtimehh" type="text" size="2" maxlength="2"/> <input class="smallwidth" id="arrtimemm" name="arrtimemm" type="text" size="2" maxlength="2"/> -->
								</li>
								<li>
									<label for="arrplace">Arriving In (City): </label>
									<select id="arrplace" name="arrplace" size="1">
										<!-- TMPL_VAR NAME=ARRCITYOPTIONS -->
									</select>
								</li>
							</ol>
							<hr />
							<h2>Starting City of Tour</h2>
							<p>The starting city of your may be the same city as where the airport is located or can
							be another city nearby where you would like to spend your first night. For instance, your
							flight may land in Chennai but you may want to spend the night in nearby Mamallapuram.</p>  
							<ol>
								<li>
									<label for="startplace">Start Tour From (City): </label>
									<select id="startplace" name="startplace" size="1">
										<!-- TMPL_VAR NAME=STARTCITYOPTIONS -->
									</select>
								</li>
							</ol>							
							<hr />
							<h2>Departure</h2>
							<ol>
								<li>
									<Label for="depdate">Departure Date: </Label>
									<input id="depdate" name="depdate" type="text" /><br />
								</li>
								<li>
									<label for="depplace">I am departing from: </label>
									<select id="depplace" name="depplace" size="1">
										<!-- TMPL_VAR NAME=ARRCITYOPTIONS -->
									</select>
								</li>
							</ol>
						</fieldset>
						<fieldset class="submit">
							<input type="image" src="images/start-my-tour.gif" width="203" height="25" name="submit" value="Start my Tour!" />
						</fieldset>
						<input type="hidden" name="mode" value="start" />
					</form>
				</div>
				<div class="span-8 rightcol last">
					<h3>Travel to India Made Easy</h3>
					<div class="box">
						<p>
							<img src="images/shalome_pat.jpg" width="280" height="140" style="margin-bottom: 6px;" />
						</p>
						<p><strong>Dear Traveller,</strong></p>
						<p>Half the fun of travel is planning and all you need is an idea. Have you dreamed about staying in a Maharaja's palace, cruising along Kerala's 
						backwaters on a converted rice barge or doing a yoga course in Rishikesh?</p>
						<p>Use our amazing Trip Planner to start converting your dreams into reality. It is absolutely free and without any obligation to make a booking.</p>
						<p>The beauty of our Trip Planner is that is puts you in charge. You can build your own itinerary in the way you like to travel by picking and 
						choosing whatever appeals most to you most.</p>
						<p>You'll find that planning a tour to India has never been easier!</p>
						<p>Enjoy your trip!</p>
						<p><strong>Shalome Potnis<br />(Product Manager)</strong></p>
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

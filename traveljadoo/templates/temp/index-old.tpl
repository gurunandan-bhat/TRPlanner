<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/ui.datepicker.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="js/jquery-ui-personalized-1.6rc2.min.js"></script>
		<script type="text/javascript" src="js/intro.js"></script>
		<title>Odyssey: Design your own Tour</title>
	</head>
	<body>
		<div class="container">
			<div class="column span-24 last banner">
				<div class="flasher">
				<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" height="120" id="MyFirstChart" >
					<param name="movie" value="images/Jadoo.swf" />
					<embed src="images/Jadoo.swf" quality="high" height="120" name="MyFirstChart" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
				</object>
				</div>
				<ul>
					<li><a href="#">Contact Us</a></li>
					<li><a href="#">About Us</a></li>
					<li><a href="#">Plan a Trip</a></li>
					<li><a href="#">Itineraries</a></li>
					<li><a href="#">Special Places</a></li>
					<li><a href="#">Home</a></li>
				</ul>
			</div>
			<div class="column span-24 last city">
				<div class="column span-16">
					<div id="slideshow" class="mainimg">
						<img src="images/city_2_large_02.jpg" width="600" height="370" alt="1" />
					</div>
				</div>
				<div class="column span-8 last description">
				<!-- TMPL_IF NAME=SUMMARY -->
					<h1>Welcome Back <!-- TMPL_VAR NAME=PAXNAME --></h1>
					<p>You have saved the following Tour Plan.</p>
					<p><a href="index.cgi?mode=restart" target="_blank">Click Here</a> if you want to see the details of your saved itinerary
					(opens details in a separate window).</p>
					<!-- TMPL_VAR NAME=SUMMARY -->
					<p><a href="travel.cgi?mode=move_on&destid=<!-- TMPL_VAR NAME=CURRCITYID -->">Click here</a> to continue building your tour from 
					<!-- TMPL_VAR NAME=CURRCITY -->.</p>
					<p class="notice">In case you want to start afresh, just fill in the form below. Note that your current tour plan will be erased 
					in case you choose to start afresh.</p>
				<!-- TMPL_ELSE -->
					<h1>Welcome Gentle Traveler</h1>
					<p>To build your tour, we first need some information. Please fill the form below and click on "Start My Tour".</p>
				<!-- /TMPL_IF -->
				</div>
			</div>
			<div class="span-13">
				<div class="moveon">
					<div id="tabs">
						<ul>
							<li class="selected"><a href="#" title="intro">Introduction</a></li>
							<li><a href="#" title="hotels">Hotels</a></li>
							<li><a href="#" title="transport">Transport</a></li>
							<li><a href="#" title="airtravel">Air Travel</a></li>
							<li><a href="#" title="traintravel">Train Travel</a></li>
						</ul>
					</div>
					<div id="intro">
						<p>Dear Traveller,</p> 
						<p>We have kept our questionnaire to an absolute minimum but let us explain why we need the following details.</p>
						<p>We require a lead name (e.g. your name) to store your itinerary once you have finished designing your own tour. 
						The country of residence we asked at the beginning is important as different tariffs apply to Indian residents. 
						Prices in Indian Rupees are applicable only to those domiciled in India, whether Indian nationals or foreign nationals 
						with a Resident Permit. US Dollar prices are applicable for Non Resident Indians and foreign nationals.</p>
						<p>The number of passengers and rooming requirement have an impact on the final price. Sharing a car with 4 
						people works out more economical than travelling with two.</p>
						<p>The starting date of your trip affects the choice of travel options. Some flights and trains may only operate 
						on certain days of the week. A monument like the Taj Mahal is closed on Fridays. The time of the year that you travel 
						may also affect the cost of your tour as hotels can be more expensive in peak season.</p>
						<p>Enjoy your trip!</p>
					</div>
					<div id="hotels">
						<h1>Hotels in India</h1>
						<p>In India, you find an enormously wide range of accommodation with options to suit all budgets. There are luxury hotels 
						with all the 5-star facilities and home stays in privately owned properties with simple and basic accommodation. The 
						charm of travelling in India is this enormous variety of hotels.</p>
						<p>Where possible, we have selected hotels which offer ambience, atmosphere and personalised service or, such as in beach 
						resorts and hill stations, a wonderful location. Our emphasis is on hotel which offer `a special feel' and, in general, 
						we avoid `mass produced' type of accommodation unless there is no other choice.</p> 
						<h1>Categories</h1>
 						<p>We have classified the hotels in three broad categories:</p>
						<ul>
							<li>Luxury - USD 100 onwards</li>
							<li>Superior - USD 50 to 100</li>
							<li>Moderate - Below USD 50</li>
						</ul>
						<p>Prices are per double room. Expect to pay more in Delhi, Mumbai, and to a lesser extent, in Chennai and Kolkata.</p>
						<h2>Luxury</h2>
						<p>These are the top of the line, `life doesn't get any better than this' variety of hotels. These exceptional hotels maybe 
						modern or converted palaces, often run by large hotel chains. They are in the metropolitan cities or in exclusive locations 
						such as a commanding coastal promontory, a lake island or a scenic hilltop, with virtually nothing to fault them. They have 
						high class business facilities, specialist restaurants and well-stocked bars, several pools, sports etc.</p>
						<h2>Superior</h2>
						<p>These excellent hotels may be modern, purpose built hotels or converted palaces, colonial style buildings or properties 
						built in a local style. This category includes some of the most atmospheric heritage hotels furnished with authentic period 
						furniture and accessories. There are also fabulous resorts amongst breathtaking scenery, most with a swimming pool and other 
						recreational facilities.</p>
 						<h2>Moderate</h2>
						<p>These hotels will be modern hotels of a medium standard or converted forts and palaces, often with the owner-families 
						still in residence. This category also includes some delightful home and farm stays. Rooms will be clean but simple and may 
						not offer many amenities. However, all rooms will still have attached bathroom (showers). No pretensions to grandeur 
						but great value for money.</p>
						<h2>Heritage Hotels</h2>
						<p>Our favourite hotels are old Maharajas' palaces and forts which have been privately converted into comfortable, unusual 
						hotels, known as the `Heritage Hotels'. These hotels range from moderate to luxury and wherever a building can authentically 
						be called `heritage' we have marked it as such. You find these heritage hotels all over India but mainly in Rajasthan and 
						Gujarat. Most of the heritage hotels are about a hundred years old or more and furnished in authentic period furniture and 
						accessories. Given the age of the buildings, the plumbing can be erratic at times but the charm of a living in a century-old 
						building more than compensates. In many of these places, the family is still in residence and you may enjoy your meals with them. 
						So do not be surprised if you find yourself having tea with His Highness the Maharaja at his family dining table! One of the 
						charms of the places we have selected is that they are often small. However, since they are small they tend to get fully booked 
						in peak season (October to March in most of India) so it is important to book well in advance.</p> 
					</div>
					<div id="transport">
						<h1>Your Transport</h1> 
						<p>This is the best way to travel in India if you intend to concentrate on a particular state or region. It is often the only 
						choice for reaching many of the places of outstanding interest in which India is so rich.</p>
						<p>A car with a driver is reasonably priced by Western standards. It is often cheaper than a self-drive car in Europe. A car 
						shared by 3 or 4 can be very good value. Moreover, it offers you great comfort and flexibility as you can stop when and wherever 
						you want to take a picture or to have a cup of Â‘chai'.</p>
						<p>The driver is at your disposal for the entire period that you travel by car. There is no charge for overnight stops. The 
						driver will make arrangements for his own accommodation and meals.</p>
						<p>Since air-conditioning uses a lot of petrol (which is expensive in India), a non-a/c car will cost substantially less than one 
						with a-c. However, we strongly recommend to take an air-conditioned car if you travel during the period April to October. During 
						the period November to March, temperatures in India are mostly pleasant and air-conditioning is not a necessity.</p>
						<p>The moderate hire car in India is the Ambassador, a car designed by the British in the 1940s. The superior segment includes 
						Maruti Esteem, Daewoo Cielo, Ford Lancer, Honda City etc.</p>
						<p>Luxury cars like Mercedes Benz and BMW are only available in the metropolitan centres, and at a much higher rate.</p> 
					</div>
					<div id="airtravel">
						<h1>Traveling by Air</h1>
						<p>Domestic airlines link major towns and cities in India. It is essential to book as early as possible, especially in the peak 
						season. For long journeys flying saves time - but often not so much as you may hope!</p>
						<p>The entry of privately owned domestic carriers such as Jet Airways and Sahara Airlines has forced Indian Airlines, the national 
						domestic carrier, to improve its service, but all domestic flights are still subject to delays, and some scheduled departures 
						are canceled without departures.</p>
						<p>Despite the improvements in air travel it can be a very frustrating experience, and for shorter distances such as Jaipur to Delhi 
						it is often quicker to travel by car. For certain routes, such as Delhi to Agra, it is much faster to travel by train than by air.</p>
						<p>When you choose to fly, do remember not to fly on two consecutive days as delays may occur. This will cause you to lose valuable 
						time at the airports while leaving you very little time to see the city, before you have to catch a flight to the next destination.</p>
						<p>Check in no later than 60 minutes before flight time and expect tight security at airports. If you fail to show up 30 minutes 
						before the flight, this is regarded as a `no show' and you forfeit the full value of the ticket. Air India domestic flights leave 
						from the international rather than the domestic terminals; check-in time is usually two hours.</p>
						<p>Indian Airlines accepts no responsibility if you lose your tickets. They absolutely will not refund lost tickets, but at their 
						discretion may issue replacements.</p>
					</div>
					<div id="traintravel">
						<h1>Traveling by Train</h1> 
						<p>Travelling on the world's second largest railway network is an experience that you should have at least once.</p>
						<p>Generally of a lower standard than their European counterparts, the Indian trains are nevertheless quite comfortable. 
						Considering the volume of passengers it is reasonably efficient, however delays do occur, and they can be lengthy.</p>
						<p>There are fast day trains, the Shatabdi Express and Intercity Express trains, which link important tourist places. 
						They have air-conditioned `chair-car' compartments which have reclining seats (like an aircraft). Snacks and meals 
						are often included in the ticket.</p>
						<p>On overnight journeys, the best option is to travel by sleeper train. First Class air-conditioned sleepers are generally private 
						compartments with two or four berths in them, sometimes with toilet as well. Usually, the sleeping berths fold up to make a sitting 
						compartment during the day.</p>
						<p>Air-conditioned Second Class carriages have berths along a common isle, with privacy provided by curtains. Each carriage has two 
						toilets on either end. Fresh bedding is provided at night at a small extra cost but we still suggest that for 2nd class you bring a 
						sleeping bag or cotton sleeping sheet depending on the season you visit.</p>
						<p>Meals are not included during an overnight train journey (apart from Rajdhani express trains). However, meals are served on board 
						the train.</p>
						<p>At the time of travel, be sure you arrive at the station with enough time to find your seat - the sleeper and seat numbers are 
						displayed on the platform and on each carriage, along with a list of passengers' names and seat assignments.</p> 
					</div>
				</div>
			</div>
			<div class="span-11 last self">
				<div class="questions">
					<h1>A Few Questions before we begin...</h1>
					<p>We have created a unique Travel Wizard that lets you put together a customised tour online. You simply choose the places you wish to visit, 
					and select your preferred mode of transport. Our Travel Wizard then creates a suggested itinerary with a costing. You are able to amend the 
					proposed itinerary to arrive at a program of your choice.</p>
					<p>Take your time and enjoy your trip.</p>
					<form method="post" action="index.cgi">
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
								<option value="4">Luxury</option>
								<option value="3">Superior</option>
								<option value="2" selected="selected">Moderate</option>
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
							<label for="double">Double Room(s): </label>
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
							<label for="twin">Twin-bedded Room(s): </label>
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
							<Label for="arrtime">Arrival Time: </Label>
							<input id="arrtime" name="arrtime" type="text" /><br />
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
							<!-- TMPL_LOOP NAME=STARTCITIES -->
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
								<option value="<!-- TMPL_VAR NAME=CITIES_ID -->"<!-- TMPL_IF NAME=DEFDEPCITY --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=CITY --></option>
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
	</body>
</html>

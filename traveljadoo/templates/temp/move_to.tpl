<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="js/jquery.cycle.pack.js"></script>
		<script type="text/javascript" src="js/odyssey.js"></script>
		<script type="text/javascript" src="js/otheroptions.js"></script>
		<title>Odyssey: What can you do in <!-- TMPL_VAR NAME=CURRNAME --></title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="span-24 last city">
				<div class="column span-16">
					<div id="slideshow" class="mainimg" thiscity="<!-- TMPL_VAR NAME=CURRID -->" maxcityimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="images/city_<!-- TMPL_VAR NAME=CURRID -->_large_01.jpg" width="600" height="370" alt="1" />
						<img src="images/city_<!-- TMPL_VAR NAME=CURRID -->_large_02.jpg" width="600" height="370" alt="2" />
					</div>
				</div>
				<div class="span-8 last description">
					<h1>About <!-- TMPL_VAR NAME=CURRNAME --></h1>
					<h2><!-- TMPL_VAR NAME=CURRONELINER --></h2>
					<!-- TMPL_VAR NAME=CURRWRITEUP -->
				</div>
			</div>
			<div class="span-16">
				<div class="moveon">
					<div id="tabs">
						<ul>
							<li class="selected"><a href="#" title="defaulthotel">Your Hotel in <!-- TMPL_VAR NAME=CURRNAME --></a></li>
							<!-- TMPL_IF NAME=THEREAREHOTELS --><li><a href="#" title="hotels">Other Hotels in <!-- TMPL_VAR NAME=CURRNAME --></a></li><!-- /TMPL_IF -->
							<li><a href="#" title="places">Things to See &amp; Do</a></li>
						</ul>
					</div>
					<div id="defaulthotel">
						<div class="option">
							<h1><!-- TMPL_VAR NAME=DEFAULTHOTELNAME --></h1>
							<div class="hotelimages">
								<img class= "first" src="images/defaulthotel_<!-- TMPL_VAR NAME=DEFAULTHOTELID -->_left.jpg" width="290" height="200" />
								<img class= "second" src="images/defaulthotel_<!-- TMPL_VAR NAME=DEFAULTHOTELID -->_right.jpg" width="290" height="200" />
							</div>
							<div class="overview">
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Overview</h2>
									<p><!-- TMPL_VAR NAME=DEFAULTHOTELDESCRIPTION --></p>
								</div>
							</div>
							<p><img src="images/hotel_<!-- TMPL_VAR NAME=DEFAULTHOTELID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" /></p>
							<div class="accommodation">
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Accommodation</h2>
									<!-- TMPL_VAR NAME=DEFAULTHOTELDETAIL1 -->
								</div>
								<hr />
								<h2>Tariff (in Euro)</h2>
								<!-- TMPL_VAR NAME=TARIFF -->
								<hr />
							</div>
							<p><img src="images/hotel_<!-- TMPL_VAR NAME=DEFAULTHOTELID -->_collage_02.jpg" width="590" height="160" alt="Image Not Available" /></p>
						</div>
					</div>
					<!-- TMPL_IF NAME=THEREAREHOTELS -->
					<div id="hotels">
						<!-- TMPL_IF NAME=MODHOTELS -->
						<h1>Moderate Hotels</h1>
						<!-- TMPL_LOOP NAME=MODHOTELS -->
						<div class="option">
							<h2><!-- TMPL_VAR NAME=HOTELNAME --></h2>
							<div class="hotelimages">
								<img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" />
							</div>
							<div class="overview">
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Overview</h2>
									<p><!-- TMPL_VAR NAME=HOTELDESCRIPTION --></p>
									<p class="hoteldetail"><a href="hotel.cgi?id=<!-- TMPL_VAR NAME=HOTELID -->">Read more about <!-- TMPL_VAR NAME=HOTELNAME --></a></p>
								</div>
							</div>
							<div class="accommodation">
								<p><img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_02.jpg" width="590" height="160" alt="Image Not Available" /></p>
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Accommodation</h2>
									<!-- TMPL_VAR NAME=HOTELDETAIL1 -->
								</div>
								<hr />
								<h2>Tariff (in Euro)</h2>
								<!-- TMPL_VAR NAME=TARIFF -->
								<hr />
							</div>
						</div>
						<hr />
						<!-- /TMPL_LOOP -->
						<!-- /TMPL_IF -->
						<!-- TMPL_IF NAME=SUPHOTELS -->
						<h1>Superior Hotels</h1>
						<!-- TMPL_LOOP NAME=SUPHOTELS -->
						<div class="option">
							<h2><!-- TMPL_VAR NAME=HOTELNAME --></h2>
							<div class="hotelimages">
								<img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" />
							</div>
							<div class="overview">
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Overview</h2>
									<p><!-- TMPL_VAR NAME=HOTELDESCRIPTION --></p>
									<p class="hoteldetail"><a href="hotel.cgi?id=<!-- TMPL_VAR NAME=HOTELID -->">Read more about <!-- TMPL_VAR NAME=HOTELNAME --></a></p>
								</div>
							</div>
							<div class="accommodation">
								<p><img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_02.jpg" width="590" height="160" alt="Image Not Available" /></p>
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Accommodation</h2>
									<!-- TMPL_VAR NAME=HOTELDETAIL1 -->
								</div>
								<hr />
								<h2>Tariff (in Euro)</h2>
								<!-- TMPL_VAR NAME=TARIFF -->
								<hr />
							</div>
						</div>
						<hr />
						<!-- /TMPL_LOOP -->
						<!-- /TMPL_IF -->
						<!-- TMPL_IF NAME=LUXHOTELS -->
						<h1>Luxury Hotels</h1>
						<!-- TMPL_LOOP NAME=LUXHOTELS -->
						<div class="option">
							<h2><!-- TMPL_VAR NAME=HOTELNAME --></h2>
							<div class="hotelimages">
								<img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" />
							</div>
							<div class="overview">
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Overview</h2>
									<p><!-- TMPL_VAR NAME=HOTELDESCRIPTION --></p>
									<p class="hoteldetail"><a href="hotel.cgi?id=<!-- TMPL_VAR NAME=HOTELID -->">Read more about <!-- TMPL_VAR NAME=HOTELNAME --></a></p>
								</div>
							</div>
							<div class="accommodation">
								<p><img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_02.jpg" width="590" height="160" alt="Image Not Available" /></p>
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<h2>Accommodation</h2>
									<!-- TMPL_VAR NAME=HOTELDETAIL1 -->
								</div>
								<hr />
								<h2>Tariff (in Euro)</h2>
								<!-- TMPL_VAR NAME=TARIFF -->
								<hr />
							</div>
						</div>
						<hr />
						<!-- /TMPL_LOOP -->
						<!-- /TMPL_IF -->
					</div>
					<!-- /TMPL_IF -->
					<div id="places">
						<div class="option">
							<h1><!-- TMPL_VAR NAME=TITLE --></h1> 
							<p><img src="images/city_<!-- TMPL_VAR NAME=CURRID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" /></p>
							<div id="sightseeing">
								<div class="summary">
								</div>	
								<div class="detail">
									<!-- TMPL_VAR NAME=CURRWEBWRITEUP -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="column span-8 last self">
				<div class="mapcontainer">
					<!-- TMPL_UNLESS NAME=STARTINGPOINT -->
					<h1>Where am I?</h1>
					
					<p class="success">The Date is <strong><!-- TMPL_VAR NAME=DEPDATE --> - Day <!-- TMPL_VAR NAME=DEPDAYNUM --></strong> of your Tour.<br /><br />
					You are currently in <strong><!-- TMPL_VAR NAME=DEPCITYNAME --></strong> and ready to leave. You are considering <strong><!-- TMPL_VAR NAME=CURRNAME --></strong> 
					as your next destination</p>
					<p>This page describes great places to stay in <strong><!-- TMPL_VAR NAME=CURRNAME --></strong>, things you can do and places you can stay here.</p>
					<h1>Yes, I want to Stay in <!-- TMPL_VAR NAME=CURRNAME --></h1>
					<p>If you want to visit <!-- TMPL_VAR NAME=CURRNAME --> please enter your preferences here. We have chosen the best options for you. Feel free to change them if you wish
					 and click on "Submit".</p>
					 <!-- /TMPL_UNLESS NAME=STARTINGPOINT -->
					 <hr />
					<div class="cityform">
						<form method=post action="travel.cgi">
							<p>I want to stay in <!-- TMPL_VAR NAME=CURRNAME --> for 
								<select class="optdays" name="days" size="1">
									<!-- TMPL_LOOP NAME=DAYSLOOP -->
									<option<!-- TMPL_IF NAME=DAYSELECTED --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=DAYVALUE --></option>
									<!-- /TMPL_LOOP --> 
								</select>
								day(s)
							</p>
							<p>I would like to stay at the 
								<select class="opthotel" name="hotel" size="1">
									<option value="<!-- TMPL_VAR NAME=DEFAULTHOTELID -->" selected="selected"><!-- TMPL_VAR NAME=DEFAULTHOTELNAME --></option>
									<!-- TMPL_LOOP NAME=MODHOTELS -->
									<option value="<!-- TMPL_VAR NAME=HOTELID -->"><!-- TMPL_VAR NAME=HOTELNAME --></option>
									<!-- /TMPL_LOOP -->
									<!-- TMPL_LOOP NAME=SUPHOTELS -->
									<option value="<!-- TMPL_VAR NAME=HOTELID -->"><!-- TMPL_VAR NAME=HOTELNAME --></option>
									<!-- /TMPL_LOOP -->
									<!-- TMPL_LOOP NAME=LUXHOTELS -->
									<option value="<!-- TMPL_VAR NAME=HOTELID -->"><!-- TMPL_VAR NAME=HOTELNAME --></option>
									<!-- /TMPL_LOOP -->
								</select>
							</p>
							<!-- TMPL_IF NAME=STARTINGPOINT -->
								<p>You have chosen to start your tour from <!-- TMPL_VAR NAME=CURRNAME -->. We will provide you with transport to reach your Hotel.</p>
								<input type="hidden" name="travelopts" value="1" />
							<!-- TMPL_ELSE -->
								<p>Here is our recommended way to travel <strong>from</strong> <!-- TMPL_VAR NAME=FROMNAME --> <strong>to</strong> <!-- TMPL_VAR NAME=CURRNAME -->:</p>
								<!-- TMPL_VAR NAME=ROUTEOPTIONS -->
							<!-- /TMPL_IF -->
							<input type="hidden" name="mode" value="transit" />
							<input type="hidden" name="city" value="<!-- TMPL_VAR NAME=CURRID -->" />
							<p class="submit"><input type="submit" value="Take me to <!-- TMPL_VAR NAME=CURRNAME -->!" /></p>
						</form>
					</div>
					<hr />
					<!-- TMPL_UNLESS NAME=STARTINGPOINT -->
					<h1>No, Show me other places around <!-- TMPL_VAR NAME=FROMNAME --></h1>
					<ul>
						<!-- TMPL_LOOP NAME=NEARCITIES -->
						<li><a href="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=FROMID -->&destid=<!-- TMPL_VAR NAME=PREID -->"><!-- TMPL_VAR NAME=PRENAME --></a></li>
						<!-- /TMPL_LOOP -->
					</ul>
					<h1>No, Show me places farther from <!-- TMPL_VAR NAME=FROMNAME --></h1>
					<form class="nextcity" method="post" action="travel.cgi">
						<p><label for="desturl">Try out your next Destination: </label> 
							<select id="desturl" name="desturl">
							<!-- TMPL_LOOP NAME=RANDOMDESTINATION -->
								<option value="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=FROMID -->&destid=<!-- TMPL_VAR NAME=RANDOMDESTID -->"><!-- TMPL_VAR NAME=RANDOMDESTNAME --></option>
							<!-- /TMPL_LOOP -->
							</select>
							<input type="submit" value="Go!" />
							<input type="hidden" name="mode" value="randomcity" />
						</p>
					</form>
					<h1>Not in our List? Use the Map!</h1>
					<!-- <div id="map"></div> -->
					<h1>Want to end your tour?</h1>
					<p><a href="travel.cgi?mode=end_tour">Yes! End my tour now at <!-- TMPL_VAR NAME=FROMNAME --></a></p>					
					<!-- /TMPL_UNLESS -->
				</div>
			</div>
		</div>
	</body>
</html>

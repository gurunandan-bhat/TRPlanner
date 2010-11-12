<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>The Travellers Palm</title>
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection" />  
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection" /><![endif]-->  
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.cycle.all.min.js"></script>
		<script type="text/javascript" src="js/hpage.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
    </head>
    <body>
        <div class="container">
			<div class="span-24 last">
				<div class="banner"><!-- TMPL_INCLUDE NAME="bannermenu.tpl" --></div>
			</div>
			<div class="span-16 frame">
				<div class="box">
					<div id="slideshow" maxitinimages="19">
						<img src="images/hp_1.jpg" width="580" height="340" alt="1" />
						<img src="images/hp_2.jpg" width="580" height="340" alt="2" />
					</div>
				</div>
			</div>
			<div class="span-8 intro last" style="position: relative;">
				<h2><!-- TMPL_VAR NAME=TITLE --></h2>
				<div class="hometext"><p style="margin-bottom: 18px;"><!-- TMPL_VAR NAME=WRITEUP --></p></div>
			</div>
			<hr style="color: #fff; background: #fff; margin-bottom: 3px;" />
			<div class="span-8">
				<div class="box leader" goto="index.cgi?mode=init">
					<p><img class="left" src="images/menu3.jpg" width="110" height="75" /></p>
					<h3><a href="theme.cgi" style="text-decoration: none;">Themes</a></h3>
					<p><!-- TMPL_VAR NAME=THEMETEXT --></p>
				</div>
			</div>
			<div class="span-8">
				<div class="box leader" goto="hotel.cgi">
					<p><img class="left" src="images/menu1.jpg" width="110" height="75" /></p>
					<h3><a href="hotel.cgi" style="text-decoration: none;">Special Places</a></h3>
					<p><!-- TMPL_VAR NAME=SPECIALPLACESTEXT --></p>
				</div>
			</div>
			<div class="span-8 last">
				<div class="box leader" goto="region.cgi">
					<p><img class="left" src="images/menu2.jpg" width="110" height="75" /></p>
					<h3><a href="region.cgi" style="text-decoration: none;">Journey Ideas</a></h3>
					<p><!-- TMPL_VAR NAME=JOURNEYIDEASTEXT --></p>
				</div>
			</div>
			<div style="display:none;">
			<div class="span-24 content"> 
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li> &raquo; Home
							<ul>
								<li><a href="index.cgi?mode=why">Why Travel with Us</a></li>
								<li><a href="index.cgi?mode=how">Responsible Travel</a></li>
								<li><a href="index.cgi?mode=what">What to Expect</a></li>
								<li><a href="index.cgi?mode=when">Before You Go</a></li>
							</ul>
						</li>
						<li><a href="theme.cgi">Themes</a></li>
						<li><a href="hotel.cgi">Special Places</a></li>
						<li><a href="region.cgi">Modules</a></li>
						<li><a href="tours.cgi">Tours</a></li>
						<li><a href="index.cgi?mode=about">About Us</a></li>
						<li><a href="index.cgi?mode=contact">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>Our Latest Modules</h3>
					<h4><!-- TMPL_VAR NAME=ITINNAME --></h4>
					<h5><!-- TMPL_VAR NAME=ITINONELINER --></h5>
					<img src="images/itin_<!-- TMPL_VAR NAME=ITINID -->_collage_1.jpg" width="470" height="180" />
					<p><!-- TMPL_VAR NAME=ITINDESC --></p>
					<p class="morelink"><a href="itineraries.cgi?mode=describe&id=<!-- TMPL_VAR NAME=ITINID -->">Explore this Module</a></p>
					<div class="span-6">
						<h3>Special Place of the Week</h3>
						<h4><!-- TMPL_VAR NAME=HOTELNAME --></h4>
						<img src="images/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->_left.jpg" width="230" height="159" />
						<p><!-- TMPL_VAR NAME=HOTELDESC --></p>
						<p><a href="hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=HOTELID -->">Read More</a></p>
					</div>
					<div class="span-6 last">
						<h3>Theme of the Week</h3>
						<h4><!-- TMPL_VAR NAME=THEMENAME --></h4>
						<h5><!-- TMPL_VAR NAME=THEMEONELINER --></h5>
						<img src="images/theme_<!-- TMPL_VAR NAME=THEMEID -->_front.jpg" width="230" height="159" />
						<p><!-- TMPL_VAR NAME=THEMEDESC --></p>
						<p><a href="theme.cgi?mode=describe&id=<!-- TMPL_VAR NAME=THEMEID -->">Explore this Theme</a></p>
					</div>
					<hr />
				</div>
				<div class="span-8 rightcol last">
					<h3>Plan the Perfect Trip</h3>
					<p class="box"><img class="left" src="images/puzzle.jpg" width="125" height="116" /> In easy to follow steps, you can build 
					your own custom-made itinerary in our unique Trip Planner. Planning a trip to India has never been so easy!</p>
					<h3>Train Finder</h3>
					<p class="box"><img src="images/trainfinder.jpg" width="125" height="90" class="left" /> Looking for the best train connection? Our innovative Train Finder provides the most powerful search engine 
					for the vast Indian Railways system.</p>
					<h3>Flight Finder</h3>
					<p class="box"><img src="images/flightfinder.jpg" width="125" height="90" class="left" /> Traveller's Palm presents the fastest Flight Finder in India. Tell us your starting point and destination 
					and we will give you the most convenient flight plan.</p>
					<h3>Smart Route Finder</h3>
					<p class="box"><img src="images/smartroutefinder.jpg" width="125" height="90" class="left" /> Traveller's Palm's  firecracker is the Smart Route Finder, an astonishing tool that tells you how to travel 
					from A to B in the best combination of trains, drives and flights!</p>
					<h3>Get in touch with us</h3>
					<p class="box"><img class="left" src="images/getintouchwithus.gif" width="125" height="116" />
					Get advice from our travel experts. Send us an e-mail, talk to us on Skype or Yahoo messenger or give 
					us a call to put together a personal itinerary for you.<br /><a href="#">Read more</a></p>
					<hr />
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

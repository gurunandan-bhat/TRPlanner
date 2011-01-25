<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/favourites.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<title>Odyssey: My Traveller's Palm</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<a name="top"></a>
				<!-- TMPL_IF NAME=FROMTOUR -->
					<!-- TMPL_INCLUDE NAME="bannermenu_tours.tpl" -->
				<!-- TMPL_ELSE -->
					<!-- TMPL_INCLUDE NAME="bannermenu_modules.tpl" -->
				<!-- /TMPL_IF -->										
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/banners/banner_myfavourites.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="#favmods">Favourite Mini Itineraries</li>
						<li><a href="#favtours">Favourite Indian Journeys</a></li>
						<li><a href="#favhotels">Favourite Hotels</a></li>
						<li><a href="#favcities">Favourite Cities</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<a name="favmods"></a>
					<h3>Your Favourites Mini Itineraries</h3>
					<!-- TMPL_LOOP NAME=ITINS -->
					<h4><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->itineraries.cgi?mode=describe&id=<!-- TMPL_VAR NAME=ID -->"><!-- TMPL_VAR NAME=NAME --></a></h4>
					<h6><!-- TMPL_VAR NAME=ONLINER --></h6>
					<p><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/mod_<!-- TMPL_VAR NAME=ID -->_small.jpg" width="240" height="150" /> <!-- TMPL_VAR NAME=DESC --><br />
					<span style="font-size: 10px;"><strong>Duration:</strong> <!-- TMPL_VAR NAME=DURATION --><br /><strong>Cost:</strong> <!-- TMPL_VAR NAME=COST --></p>
					<p class="addquote" style="font-size: 10px;"><!-- TMPL_VAR NAME=ADDQUOTE --></p>
					<p class="showquote" style="font-size: 10px;"><!-- TMPL_VAR NAME=SHOWQUOTE --></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<a name="favtours"></a>
					<a href="#top">Top</a>
					<h3>Your Favourite Indian Journeys</h3>
					<!-- TMPL_LOOP NAME=RTOURS -->
					<h4><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->itineraries.cgi?mode=describe&id=<!-- TMPL_VAR NAME=ID -->"><!-- TMPL_VAR NAME=NAME --></a></h4>
					<h6><!-- TMPL_VAR NAME=ONLINER --></h6>
					<p><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/itin_<!-- TMPL_VAR NAME=ID -->_small.jpg" width="240" height="142" /> <!-- TMPL_VAR NAME=DESC --><br />
					<span style="font-size: 10px;"><strong>Duration:</strong> <!-- TMPL_VAR NAME=DURATION --><br /><strong>Cost:</strong> <!-- TMPL_VAR NAME=COST --></p>
					<p class="addquote" style="font-size: 10px;"><!-- TMPL_VAR NAME=ADDQUOTE --></p>
					<p class="showquote" style="font-size: 10px;"><!-- TMPL_VAR NAME=SHOWQUOTE --></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<a name="favhotels"></a>
					<a href="#top">Top</a>
					<h3>Your Favourite Hotels</h3>
					<!-- TMPL_LOOP NAME=HOTELS -->
					<h4><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=ID -->"><!-- TMPL_VAR NAME=NAME --></a></h4>
					<p><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/defaulthotel_<!-- TMPL_VAR NAME=ID -->.jpg" width="240" height="142" /> <!-- TMPL_VAR NAME=DESC --></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<hr />
					<a name="favcities"></a>
					<a href="#top">Top</a>
					<h3>Your Favourite Cities</h3>
					<!-- TMPL_LOOP NAME=CITIES -->
					<h4><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel.cgi?mode=search&subject=city&id=<!-- TMPL_VAR NAME=ID -->"><!-- TMPL_VAR NAME=NAME --></a></h4>
					<p><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/city_<!-- TMPL_VAR NAME=ID -->_large_2.jpg" width="240" height="148" /> <!-- TMPL_VAR NAME=DESC --></p>
					<hr />
					<!-- /TMPL_LOOP -->
				</div>
				<div class="span-8 rightcol last">
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->itineraries.cgi?mode=quotes">Request a Quote</a></h3>
					<p class="box"><!-- TMPL_VAR NAME=ADTEXT1 --><br /><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->itineraries.cgi?mode=quotes">Request a Quote</a></p>
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->index.cgi?mode=contact">Get in touch with us</a></h3>
					<p class="box"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/getintouchwithus.gif" width="125" height="116" /><!-- TMPL_VAR NAME=ADTEXT2 --><br /><a href="index.cgi?mode=contact">Contact Us</a></p>
					<hr />
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/hotelsearch.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				Hotel Types | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
		<title>Odyssey: About Us</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_splaces.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="images/banners/banner_hotelcategories.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="/">Home</li>
						<li><a href="/themes">Incredible India</a></li>
						<li><a href="/special_places">Special Places</a>
							<ul>
								<li><div id="current"> &raquo; Hotel Categories</div></li>
								<li><a href="heritage-hotels">Heritage Hotels</a></li>
								<li><a href="/home-stays">Home Stays</a></li>
							</ul>
						</li>
						<li><a href="/modules">Mini Itineraries</a></li>
						<li><a href="/tours">Indian Journeys</a></li>
						<li><a href="/about-us">About Us</a></li>
						<li><a href="/contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3><!-- TMPL_VAR NAME=TITLE --></h3>
					<!-- TMPL_VAR NAME=WRITEUP -->
					<hr />
				</div>
				<div class="span-8 rightcol last">
					<h3>Search for Hotels</h3>
					<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
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

			
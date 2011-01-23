<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!-- <meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> -->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection" charset="utf-8" />
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection" charset="utf-8" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/tabs.css" type="text/css" media="screen, projection" charset="utf-8" />
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/regions.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				Where to Go in India - Independent Itinerary Ideas | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_modules.tpl" -->
			</div>
			<div class="span-24 subcategory last">
				<div class="span-16">
					<div id="imgframe">
						<div id="thememapholder">
							<div id="thememap" style="width: 560px; height: 340px;"></div>
						</div>
					</div>
					<div class="prepend-5 span-8 append-3 last">
						<p id="mapnote">Click on a Label to select a Region</p>
					</div>
				</div>
				<div class="span-8 writeup last">
					<div id="writeup">
						<h1><!-- TMPL_VAR NAME=TITLE --></h1>
						<h2>&nbsp;</h2>
						<div id="themedesc"><!-- TMPL_VAR NAME=WRITEUP --></div>
					</div>
				</div>
			</div>
			<hr />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a></li>
						<li><a id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>Mini Itineraries</h3>
					<!-- TMPL_LOOP NAME=REGIONS -->
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->"><h4 class="listmods"><!-- TMPL_VAR NAME=REGIONNAME --></h4></a>
					<p>
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->">
							<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/region_<!-- TMPL_VAR NAME=REGIONID -->_small.jpg" width="220" height="151" />
						</a>
						<!-- TMPL_VAR NAME=REGIONDESC --><br />
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->">Explore Modules in this Region</a>
					</p>
					<hr class="space" />
					<!-- /TMPL_LOOP -->
				</div>
				<div class="span-8 rightcol last">
					<h3><!-- TMPL_VAR NAME=SIDETITLE --></h3>
					<!-- TMPL_LOOP NAME=TOP10 -->
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/top10/highlights_<!-- TMPL_VAR NAME=T10ID -->.gif" width="114" height="114" />
						<h4><!-- TMPL_VAR NAME=T10TITLE --></h4>
						<div class="hansbold"><!-- TMPL_VAR NAME=T10TEXT --></div>
					</div>
					<!-- /TMPL_LOOP -->
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

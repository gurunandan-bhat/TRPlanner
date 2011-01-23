<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/favourites.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				India Itineraries - Recommended Travel Ideas | Traveller's Palm
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_modules.tpl" -->					
			</div>
			<div class="span-16">
				<div id="imgframe">
					<div id="frameslideshow"">
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/region_<!-- TMPL_VAR NAME=REGIONID -->_large.jpg" width="560" height="340" alt="1" />
					</div>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1><!-- TMPL_VAR NAME=REGIONNAME --></h1>
					<h2>&nbsp;</h2>
					<!-- TMPL_VAR NAME=REGIONLONGDESC -->
				</div>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a></li>
						<li><a id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a>
							<ul>
								<li><div id="current"><!-- TMPL_VAR NAME=REGIONNAME --></div></li>
								<!-- TMPL_LOOP NAME=REGIONS -->
								<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->"><!-- TMPL_VAR NAME=REGIONNAME --></a></li>
								<!-- /TMPL_LOOP -->
							</ul>
						</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>Modules in <!-- TMPL_VAR NAME=REGIONNAME --></h3>
					<!-- TMPL_LOOP NAME=ITINS -->
					<div class="vheaderbox">
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->moduledetails/<!-- TMPL_VAR NAME=ITINURL -->"><h4 class="listmods"><!-- TMPL_VAR NAME=ITINNAME --></h4></a>
						<h5 class="listmods"><!-- TMPL_VAR NAME=ITINONELINER --></h5>
					</div>
					<p>
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->moduledetails/<!-- TMPL_VAR NAME=ITINURL -->">
							<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/mod_<!-- TMPL_VAR NAME=ITINID -->_small.jpg" width="220" height="150" class="left" />
						</a>
						<!-- TMPL_VAR NAME=ITINDESC -->
					</p>
					<p class="box"><strong>Duration:</strong> <!-- TMPL_VAR NAME=ITINDURATION --><br /><strong>Price:</strong> <!-- TMPL_VAR NAME=ITINPRICE --></p>
					<hr />
					<!-- /TMPL_LOOP -->
				</div>
				<div class="span-8 rightcol last">
					<h3>Other Regions</h3>
					<!-- TMPL_LOOP NAME=REGIONS -->
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/regions_<!-- TMPL_VAR NAME=REGIONID -->_1.gif" width="114" height="114" />
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->"><h4><!-- TMPL_VAR NAME=REGIONNAME --></h4></a>
						<p><!-- TMPL_VAR NAME=REGIONDESC --><br /><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->">Explore Modules in this Region</a></p>
					</div>
					<hr class="space" />
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

			
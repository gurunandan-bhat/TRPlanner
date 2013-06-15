<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/favourites.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				India Itineraries - Recommended Travel Ideas | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_tours.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/itineraries_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->regions">Mini Itineraries</a></li>
						<li><a id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>Our Tours</h3>
					<p>
						There are <!-- TMPL_VAR NAME=TOURCOUNT --> Tours.
						<!-- TMPL_IF NAME=PAGE -->
							Displaying <!-- TMPL_VAR NAME=PAGECOUNTPLUSONE --> to <!-- TMPL_VAR NAME=TOURCOUNT -->: 
						<!-- TMPL_ELSE -->
							Displaying 1 to <!-- TMPL_VAR NAME=PAGECOUNT -->:
						<!-- /TMPL_IF -->
						Page: <!-- TMPL_IF NAME=FIRSTPAGE --> 1 | <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours/2">2 &raquo;</a> <!-- TMPL_ELSE --> <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours/1">&laquo; 1</a> | 2<!-- /TMPL_IF -->
					</p>
					<!-- TMPL_LOOP NAME=TOURS -->
					<div class="vheaderbox">
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=TOURURL -->"><h4 class="listmods"><!-- TMPL_VAR NAME=TOURNAME --></h4></a>
						<h5 class="listmods"><!-- TMPL_VAR NAME=TOURONELINER --></h5>
					</div>
					<p>
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=TOURURL -->"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/tours/rt_<!-- TMPL_VAR NAME=TOURID -->_small.jpg" width="220" height="151" class="left" /></a>
						<!-- TMPL_VAR NAME=TOURINTRO -->
					</p>
					<p class="box">
						<strong>Duration:</strong> <!-- TMPL_VAR NAME=TOURDURATION --><br />
						<strong>Price:</strong> <!-- TMPL_VAR NAME=TOURPRICE -->
					</p>
					<hr />
					<!-- /TMPL_LOOP -->
					<p>
						Page: <!-- TMPL_IF NAME=FIRSTPAGE --> 1 | <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours/2">2 &raquo;</a> <!-- TMPL_ELSE --> <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours/1">&laquo; 1</a> | 2<!-- /TMPL_IF -->
					</p>
				</div>
				<div class="span-8 rightcol last">
					<h3><!-- TMPL_VAR NAME=SIDETITLE --></h3>
					<div class="box">
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/team.jpg" width="240" height="150" /> 	
						<div style="font-style: italic;"><!-- TMPL_VAR NAME=SIDETEXT --></div>
					</div>
					<hr class="space" />
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

			

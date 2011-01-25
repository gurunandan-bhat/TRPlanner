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
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/hotelsearch.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				Special Places to Stay - Independent India Travel | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_splaces.tpl" -->
			</div>
			<div class="span-16">
				<div id="imgframe">
					<div id="frameslideshow">
						<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="560" height="340" id="statemap">
							<param name="movie" value="test.swf">
							<embed src="test.swf" quality=high width="560" height="340" name="statemap" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
							</embed>
						</object>
					</div>
				</div>
				<div class="prepend-5 span-8 append-3 last">
					<p id="mapnote">Click on a State to see details</p>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1>Special Places</h1>
					<h2>&nbsp;</h2>
					<!-- TMPL_VAR NAME=TEXT -->
					<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
				</div>
			</div>
			<hr />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>States of India</h3>
					<!-- TMPL_LOOP NAME=STATES -->
					<div class="vheaderbox">
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->state/<!-- TMPL_VAR NAME=STATEURL -->"><h4 class="listmods"><!-- TMPL_VAR NAME=STATE --></h4></a>
						<h5 class="listmods"><!-- TMPL_VAR NAME=STATEONELINER --></h5>
					</div>
					<p>
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->state/<!-- TMPL_VAR NAME=STATEURL -->"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/state/state_<!-- TMPL_VAR NAME=STATEID -->_small.jpg" width="220" height="151" class="left" /></a>
						<!-- TMPL_VAR NAME=STATEWRITEUP -->
					</p>
					<hr />
					<!-- /TMPL_LOOP -->
				</div>
				<div class="span-8 rightcol last">
					<h3>Fairs and Festivals of India</h3>
					<!-- TMPL_LOOP NAME=FAIRS -->
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/fairs/fair_<!-- TMPL_VAR NAME=FAIRID -->.gif" width="114" height="114" />
						<h4><!-- TMPL_VAR NAME=FAIRNAME --></h4>
						<p><!-- TMPL_VAR NAME=FAIRDESC --><br /></p>
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

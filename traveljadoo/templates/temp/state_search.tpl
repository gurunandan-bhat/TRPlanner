<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>About <!-- TMPL_VAR NAME=STATENAME --></title>
		<!-- Framework CSS -->
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print">
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection">
		<!--[if lt IE 8]><link rel="stylesheet" href="css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAANNgAl6Yk0J_LHL8ee--iiBRKRT3lEAXbWt9bKSuE5xGrJNjhaBSmYrPob9NYNAyq2W3hgzWgqsVk9g" type="text/javascript"></script>
		<script type="text/javascript" src="js/jquery.jmap.min-r72.js"></script>
		<script type="text/javascript" src="js/odyssey.js"></script>
		<script type="text/javascript" src="js/hotelsearch.js"></script>
		<script type="text/javascript" src="js/odyssey_statemap.js"></script>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="span-16">
				<div class="box">
					<div id="big_map" style="width: 600px; height: 360px;" lat="<!-- TMPL_VAR NAME=LATITUDE -->" lng="<!-- TMPL_VAR NAME=LONGITUDE -->" thiscity="<!-- TMPL_VAR NAME=CURRID -->"></div>
				</div>
			</div>
			<div class="span-8 intro last">
				<h2>About <!-- TMPL_VAR NAME=STATENAME --></h2>
				<h4><!-- TMPL_VAR NAME=STATEONELINER --></h4>
				<!-- TMPL_VAR NAME=STATEWRITEUP -->
				<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Home</h3>
					<p class="box">
						100% Tailor-made<br />
						Specialist knowledge<br />
						Responsible travel<br />
						What you can expect<br />
						When to Go
					</p>
					<h3>Special Places</h3>
					<p class="box">
						Introduction<br />
						Regions<br />
						Cities<br />
						<!-- TMPL_IF NAME=OTHERCITIES -->
						<ul>
							<!-- TMPL_LOOP NAME=OTHERCITIES -->
							<li><a href="hotel.cgi?mode=cityhotels&sid=<!-- TMPL_VAR NAME=OTHERSTATEID -->&cid=<!-- TMPL_VAR NAME=OTHERCITYID -->&city=1"><!-- TMPL_VAR NAME=OTHERCITYNAME --></a></li>
							<!-- /TMPL_LOOP -->
						</ul>
						<!-- /TMPL_IF -->
						Hotels
					</p>
					<h3>Journey Ideas</h3>
					<p class="box">
						Itineraries<br />
						Highlights<br />
						Themes<br />
						Features
					</p>
					<h3>Trip Planner</h3>
					<p class="box">
						Creating your tour<br />
						Train Finder <br />
						Flight Finder <br />
						Smart Route Finder
					</p>
					<h3>About Us</h3>
					<p class="box">
						Traveller's Palm<br />
						Our team<br />
						Privacy policy<br />
						Terms of use<br />
						Contact us
					</p>
				</div>
				<div class="span-12 midcol">
					<h3>About <!-- TMPL_VAR NAME=STATENAME --></h3>
					<h4>The Name of the Tour</h4>
					<h5>From Location 1 to Location 2; 12 nights</h5>
					<img src="images/red_block.gif" width="470" height="180" />
					<!-- TMPL_VAR NAME=STATEWEBWRITEUP -->
					<hr />
				</div>
				<div class="span-8 rightcol last">
					<h3>Specialists Corner</h3>
					<h4>Section Name</h4>
					<p><img class="left" src="images/red_block.gif" width="125" height="90" /></p>
					<h5>Author's Name</h5>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
					standard dummy text ever since the 1500s.</p>
					<hr />
					<h4>Section Name</h4>
					<p><img class="left" src="images/red_block.gif" width="125" height="90" /></p>
					<h5>Author's Name</h5>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
					standard dummy text ever since the 1500s.</p>
					<hr />
					<h4>Section Name</h4>
					<p><img class="left" src="images/red_block.gif" width="125" height="90" /></p>
					<h5>Author's Name</h5>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
					standard dummy text ever since the 1500s.</p>
					<hr />
					<h4>Section Name</h4>
					<p><img class="left" src="images/red_block.gif" width="125" height="90" /></p>
					<h5>Author's Name</h5>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
					standard dummy text ever since the 1500s.</p>
					<hr />
					<h4>Section Name</h4>
					<p><img class="left" src="images/red_block.gif" width="125" height="90" /></p>
					<h5>Author's Name</h5>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's 
					standard dummy text ever since the 1500s.</p>
					<hr />
				</div>
			</div>
		</div>
	</body>
</html>

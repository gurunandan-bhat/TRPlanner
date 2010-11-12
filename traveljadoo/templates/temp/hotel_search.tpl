<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<!-- Framework CSS -->
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print">
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection">
		<!--[if lt IE 8]><link rel="stylesheet" href="css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<title>Odyssey: Your Hotel Search Results</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="column span-16">
				<div class="box"><img src="images/red_block.gif" width="600" height="360" alt="1" /></div>
			</div>
			<div class="span-8 intro last">
				<h2>About <!-- TMPL_VAR NAME=CITYNAME --></h2>
				<h4><!-- TMPL_VAR NAME=CITYONELINER --></h4>
				<!-- TMPL_VAR NAME=CITYWRITEUP -->
				<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
			</div>
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
					<h3>About <!-- TMPL_VAR NAME=CITYNAME --></h3>
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

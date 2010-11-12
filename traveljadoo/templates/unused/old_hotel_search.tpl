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
		<script type="text/javascript" src="js/hotelsearch.js"></script>
		<title>Odyssey: Your Hotel Search Results</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
					<!-- TMPL_INCLUDE NAME="hotel_searchform.tpl" -->				
				</div>
			</div>
			<!-- TMPL_IF NAME=CITYTYPE -->
			<div class="span-24 last city">
				<div class="column span-16">
					<div id="slideshow" class="mainimg" thiscity="<!-- TMPL_VAR NAME=CITYID -->" maxcityimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="images/city_<!-- TMPL_VAR NAME=CITYID -->_large_01.jpg" width="600" height="370" alt="1" />
						<img src="images/city_<!-- TMPL_VAR NAME=CITYID -->_large_02.jpg" width="600" height="370" alt="2" />
					</div>
				</div>
				<div class="span-8 last description">
					<h1>About <!-- TMPL_VAR NAME=CITYNAME --></h1>
					<h2><!-- TMPL_VAR NAME=CITYONELINER --></h2>
					<!-- TMPL_VAR NAME=CITYWRITEUP -->
				</div>
			</div>
			<!-- TMPL_ELSE -->
			<div class="span-24 broadbanner last">
				<img src="images/main_banner3.jpg" width="950" height="150" alt="Collage"/>
				<hr class="bigspacer" />
			</div>
			<!-- /TMPL_IF -->
			<div class="span-16 results">
				<div id="tabs">
					<ul>
						<li class="selected"><a href="#" title="defaulthotel">Hotels in <!-- TMPL_VAR NAME=CITYNAME --></a></li>
						<li><a href="#" title="places">Things to See &amp; Do</a></li>
					</ul>
				</div>
				<div id="defaulthotel">
					<!-- TMPL_IF NAME=SEARCH --><h1>Your Search Results</h1><!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=MODHOTELS -->
						<!-- TMPL_LOOP NAME=MODHOTELS -->
						<div class="searchhotel">
							<hr />
							<div class="span-3"><a href="hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=HOTELID -->"><h2><!-- TMPL_VAR NAME=HOTELNAME --></h2></a><p><!-- TMPL_VAR NAME=HOTELCITYNAME -->, <!-- TMPL_VAR NAME=HOTELSTATENAME --></p></div>
							<div class="span-4"><img src="images/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->_left.jpg" width="120" height="83" alt="HotelImage" /></div>
							<div class="span-1">$</div>
							<div class="span-8 last"><!-- TMPL_VAR NAME=HOTELWRITEUP --></div>
						</div>
						<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=SUPHOTELS -->
						<!-- TMPL_LOOP NAME=SUPHOTELS -->
						<div class="searchhotel">
							<hr />
							<div class="span-3"><a href="hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=HOTELID -->"><h2><!-- TMPL_VAR NAME=HOTELNAME --></h2></a></div>
							<div class="span-4"><img src="images/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->_left.jpg" width="120" height="83" alt="HotelImage" /></div>
							<div class="span-1">$$</div>
							<div class="span-8 last"><!-- TMPL_VAR NAME=HOTELWRITEUP --></div>
						</div>
						<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=LUXHOTELS -->
						<!-- TMPL_LOOP NAME=LUXHOTELS -->
						<div class="searchhotel">
							<hr />
							<div class="span-3"><a href="hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=HOTELID -->"><h2><!-- TMPL_VAR NAME=HOTELNAME --></h2></a></div>
							<div class="span-4"><img src="images/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->_left.jpg" width="120" height="83" alt="HotelImage" /></div>
							<div class="span-1">$$$</div>
							<div class="span-8 last"><!-- TMPL_VAR NAME=HOTELWRITEUP --></div>
						</div>
						<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
				</div>
				<div id="places">
					<div class="option">
						<h1><!-- TMPL_VAR NAME=TITLE --></h1> 
						<p><img src="images/city_<!-- TMPL_VAR NAME=CITYID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" /></p>
						<div id="sightseeing">
							<div class="detail"><!-- TMPL_VAR NAME=CITYWEBWRITEUP --></div>
						</div>
					</div>
				</div>
			</div>
			<div class="span-8 chatter self last">
				<div class="mapcontainer">
					<!-- TMPL_IF NAME=OTHERCITIES -->
					<h1>Explore Hotels in Other Cities of <!-- TMPL_VAR NAME=STATENAME --></h1>
					<ul>
						<!-- TMPL_LOOP NAME=OTHERCITIES -->
						<li><a href="hotel.cgi?mode=cityhotels&sid=<!-- TMPL_VAR NAME=OTHERSTATEID -->&cid=<!-- TMPL_VAR NAME=OTHERCITYID -->&city=1"><!-- TMPL_VAR NAME=OTHERCITYNAME --></a></li>
						<!-- /TMPL_LOOP -->
					</ul>
					<!-- /TMPL_IF -->
				</div>
			</div>
		</div>
	</body>
</html>

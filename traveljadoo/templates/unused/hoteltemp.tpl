<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAANNgAl6Yk0J_LHL8ee--iiBQ-De2rHpQRn1piwxGxvGxlLqTVjhQZvcv_Q12H7pOROmKF7va9pvfVqw" type="text/javascript">
		</script>
		<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="js/jquery.cycle.pack.js"></script>
		<script type="text/javascript" src="js/odysseyhotels.js"></script>
		<script type="text/javascript" src="js/hotelsearch.js"></script>
		<title>Odyssey: <!-- TMPL_VAR NAME=HOTELNAME --></title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu_splaces.tpl" -->					
					<!-- TMPL_INCLUDE NAME="hotel_searchform.tpl" -->				
				</div>
			</div>
			<div class="column span-24 last city">
				<div class="column span-16">
					<div id="slideshow" class="mainimg" thishotel="<!-- TMPL_VAR NAME=HOTELID -->" maxhotelimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_01.jpg" width="600" height="370" alt="1" />
						<img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_02.jpg" width="600" height="370" alt="2" />
					</div>
				</div>
				<div class="column span-8 last description">
					<h1><!-- TMPL_VAR NAME=HOTELNAME --></h1>
					<p><!-- TMPL_VAR NAME=HOTELDESCRIPTION --></p>
				</div>
			</div>
			<div class="column span-16">
				<div class="moveon">
					<div id="tabs">
						<ul>
							<li class="selected"><a href="#" title="defaulthotel">Accommodation</a></li>
							<li><a href="#" title="places">Things to See &amp; Do</a></li>
						</ul>
					</div>
					<div id="defaulthotel">
						<div class="option">
							<div class="hotelimages">
								<img class= "first" src="images/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->_left.jpg" width="290" height="200" />
								<img class= "second" src="images/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->_right.jpg" width="290" height="200" />
							</div>
							<div id="accommodation">
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<!-- TMPL_VAR NAME=HOTELDETAIL1 -->
								</div>
								<p><img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_02.jpg" width="590" height="160" alt="Image Not Available" /></p>
								<h1>Tariff (in Euro)</h1>
								<!-- TMPL_VAR NAME=TARIFF -->
								<p><img src="images/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" /></p>
							</div>
						</div>
					</div>
					<div id="places">
						<div class="option">	
							<p><img src="images/city_<!-- TMPL_VAR NAME=HOTELCITYID -->_collage_01.jpg" width="590" height="160" alt="Image Not Available" />
							<div id="sightseeing">
								<div class="summary">
									&nbsp;
								</div>	
								<div class="detail">
									<!-- TMPL_VAR NAME=HOTELDETAIL2 -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="column span-8 last self">
				<div class="citycontainer">
					<!-- TMPL_IF NAME=OTHERHOTELS -->
					<h1>Other Hotels in <!-- TMPL_VAR NAME=HOTELCITYNAME --></h1>
					<!-- TMPL_IF NAME=MODHOTELS -->
					<ul>
					<!-- TMPL_LOOP NAME=MODHOTELS -->
						<li><a href="hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=HOTELID -->"><!-- TMPL_VAR NAME=HOTELNAME --></a> ($)</li>
					<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=SUPHOTELS -->
					<!-- TMPL_LOOP NAME=SUPHOTELS -->
						<li><a href="hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=HOTELID -->"><!-- TMPL_VAR NAME=HOTELNAME --></a> ($$)</li>
					<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=LUXHOTELS -->
					<!-- TMPL_LOOP NAME=LUXHOTELS -->
						<li><a href="hotel.cgi?mode=describe&id=<!-- TMPL_VAR NAME=HOTELID -->"><!-- TMPL_VAR NAME=HOTELNAME --></a> ($$$)</li>
					<!-- /TMPL_LOOP -->
					</ul>
					<!-- /TMPL_IF -->
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=SHOWSTATELINK -->
					<h1><a href="hotel.cgi?mode=search&subject=state&id=<!-- TMPL_VAR NAME=THISSTATEID -->">Other Hotels in <!-- TMPL_VAR NAME=THISSTATENAME --></a></h1>
					<hr />
					<!-- /TMPL_IF -->
					<h1>About <!-- TMPL_VAR NAME=HOTELCITYNAME --></h1>
					<p><div id="map_canvas" lat="<!-- TMPL_VAR NAME=LATITUDE -->" lng="<!-- TMPL_VAR NAME=LONGITUDE -->"></div></p>
					<p><!-- TMPL_VAR NAME=HOTELCITYDESCRIPTION --></p>
				</div>
			</div>
		</div>
	</body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/thickbox.css" type="text/css" media="screen" />
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.cycle.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/new_odyssey.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/hotelsearch.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/favourites.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/thickbox-compressed.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				<!-- TMPL_IF NAME=CITYTYPE -->
					<!-- TMPL_VAR NAME=CITYNAME --> in <!-- TMPL_VAR NAME=STATENAME --> - Custom Tours in India | Traveller's Palm
				<!-- TMPL_ELSE -->
					Your Hotel Search Results
				<!-- /TMPL_IF -->
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_splaces.tpl" -->					
			</div>
			<!-- TMPL_IF NAME=CITYTYPE -->
			<div class="span-16">
				<div id="imgframe">
					<div id="frameslideshow" thiscity="<!-- TMPL_VAR NAME=CITYID -->" maxcityimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/city/city_<!-- TMPL_VAR NAME=CITYID -->_large_1.jpg" width="560" height="340" alt="" title="" imgsrno = "1" imgfile="city_<!-- TMPL_VAR NAME=CITYID -->_large_1.jpg" />
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/city/city_<!-- TMPL_VAR NAME=CITYID -->_large_2.jpg" width="560" height="340" alt="" title="" imgsrno = "2" imgfile="city_<!-- TMPL_VAR NAME=CITYID -->_large_2.jpg" />
					</div>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1><!-- TMPL_VAR NAME=CITYNAME --></h1>
					<h2><!-- TMPL_VAR NAME=CITYONELINER --></h2>
					<!-- TMPL_VAR NAME=CITYWRITEUP -->
					<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
				</div>
			</div>
			<!-- TMPL_ELSE -->
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<!-- /TMPL_IF -->
			<hr class="space">
			<div class="content">
				<div class="span-4 leftcol">
				<!-- TMPL_IF NAME=CITYTYPE -->
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a  id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a>
							<ul>
								<li><a id="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->state/<!-- TMPL_VAR NAME=STATEURL -->"><!-- TMPL_VAR NAME=STATENAME --></a>
									<ul>
										<li><div id="current"><!-- TMPL_VAR NAME=CITYNAME --></div></li>
										<!-- TMPL_LOOP NAME=OTHERCITIES -->
										<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->city/<!-- TMPL_VAR NAME=OTHERCITYURL -->"><!-- TMPL_VAR NAME=OTHERCITYNAME --></a></li>
										<!-- /TMPL_LOOP -->
									</ul>
								</li>
							</ul>
						</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				<!-- TMPL_ELSE -->
				<p>&nbsp;</p>
				<!-- /TMPL_IF -->
				</div>
				<div class="span-12 midcol">
					<h3><!-- TMPL_IF NAME=SEARCH -->Your Search Results<!-- TMPL_ELSE -->Special Places to Stay in <!-- TMPL_VAR NAME=CITYNAME --><!-- /TMPL_IF --></h3>
					<p class="hotelcatnotice">'$' Signs against Hotels indicate its <a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel.cgi?mode=minihoteltypes&height=500&width=400" title="Hotel Categories" class="thickbox">Category</a></p>
					<!-- TMPL_IF NAME=NORESULTS -->
					<p>Sorry. We were not able to find any Hotels that matched your Search. Enter another Search term and try again.</p>
					<div id="relsearchunit"><!-- TMPL_INCLUDE NAME=new_hotelsearchform.tpl --></div>
					<!-- /TMPL_IF -->
					<!-- TMPL_LOOP NAME=MODHOTELS -->
					<p class="imgholder"><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->.jpg" width="220" height="150" /></a></p>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><h4><!-- TMPL_VAR NAME=HOTELNAME --> ($)</h4></a>
					<p class="hansbold"><!-- TMPL_VAR NAME=HOTELWRITEUP --></p>
					<p><a class="hotellink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->">Read More &raquo;</a></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<!-- TMPL_LOOP NAME=SUPHOTELS -->
					<p class="imgholder"><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->.jpg" width="220" height="150" /></a></p>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><h4><!-- TMPL_VAR NAME=HOTELNAME --> ($$)</h4></a>
					<p class="hansbold"><!-- TMPL_VAR NAME=HOTELWRITEUP --></p>
					<p><a class="hotellink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->">Read More &raquo;</a></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<!-- TMPL_LOOP NAME=LUXHOTELS -->
					<p class="imgholder"><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->.jpg" width="220" height="150" /></a></p>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><h4><!-- TMPL_VAR NAME=HOTELNAME --> ($$$)</h4></a>
					<p class="hansbold"><!-- TMPL_VAR NAME=HOTELWRITEUP --></p>
					<p><a class="hotellink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->">Read More &raquo;</a></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<!-- TMPL_LOOP NAME=TOPHOTELS -->
					<p class="imgholder"><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->.jpg" width="220" height="150" /></a></p>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><h4><!-- TMPL_VAR NAME=HOTELNAME --> ($$$$)</h4></a>
					<p class="hansbold"><!-- TMPL_VAR NAME=HOTELWRITEUP --></p>
					<p><a class="hotellink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->">Read More &raquo;</a></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<!-- TMPL_UNLESS NAME=SEARCH -->
					<h3>Things to see and do in <!-- TMPL_VAR NAME=CITYNAME --></h3>
					<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/city/city_<!-- TMPL_VAR NAME=CITYID -->_collage.gif" width="470" height="514" />
					<!-- TMPL_VAR NAME=CITYWEBWRITEUP -->
					<p class="fav">
						<!-- TMPL_IF NAME=ISFAVOURITE -->
						(<!-- TMPL_VAR NAME=CITYNAME -->) has been added to your favourites. Click <a href='/my-travellers-palm'>here</a> to see all your favourites
						<!-- TMPL_ELSE -->
						<a id="addtofav" href="#" registered="<!-- TMPL_VAR NAME=REGISTERED -->" type="city" objid="<!-- TMPL_VAR NAME=CITYID -->">Add <!-- TMPL_VAR NAME=CITYNAME --> to your favourites</a>
						<br />
						<form id="register" method="get" action="/">
							<fieldset>
								<legend>Register your Email Address and Add to Favourites</legend>
								Please provide your email address: <input id="emailaddr" name="emailaddr" value='' /><br />
								<input type="submit" id="registernow" value="Add Now" />
							</fieldset>
						</form>
						<!-- /TMPL_IF -->
					</p>
					<!-- /TMPL_UNLESS -->
				</div>
				<div class="span-8 rightcol last">
				<!-- TMPL_IF NAME=CITYTYPE -->
					<!-- TMPL_IF NAME=RELMODS -->
						<h3>Related Trips</h3>
						<!-- TMPL_LOOP NAME=RELMODS -->
						<div class="box">
							<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/mod_<!-- TMPL_VAR NAME=ITIN_ID -->_advert.gif" width="114" height="114" />
							<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=ITIN_URL -->"><h4><!-- TMPL_VAR NAME=ITIN_TITLE --></h4></a>
							<strong>(<!-- TMPL_VAR NAME=ITIN_DURATION -->)</strong><br />
							<div class="hansbold"><!-- TMPL_VAR NAME=ITIN_ADV --></div>
						</div>
						<hr />
					<!-- /TMPL_LOOP -->
					<!-- TMPL_ELSE -->
					<!-- TMPL_UNLESS NAME=RELTOURS -->
					<h3>Suggested Trips</h3>
					<p class="box"><!-- TMPL_VAR NAME=MODTEXT --><br /><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->region.cgi">Explore our Modules</a></p>
					<!-- /TMPL_UNLESS -->
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=RELTOURS -->
						<!-- TMPL_UNLESS NAME=RELMODS -->
						<h3>Related Trips</h3>
						<!-- /TMPL_UNLESS -->
						<!-- TMPL_LOOP NAME=RELTOURS -->
						<div class="box">
							<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/tours/rt_<!-- TMPL_VAR NAME=ITIN_ID -->_advert.gif" width="114" height="114" />
							<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=ITIN_URL -->"><h4><!-- TMPL_VAR NAME=ITIN_TITLE --></h4></a>
							<strong>(<!-- TMPL_VAR NAME=ITIN_DURATION -->)</strong><br />
							<div class="hansbold"><!-- TMPL_VAR NAME=ITIN_ADV --></div>
						</div>
						<hr />
						<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
					<h3><!-- TMPL_VAR NAME=ALTTITLE --></h3>
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/plantheperfecttrip.gif" width="114" height="114" />
						<div class="hansbold"><!-- TMPL_VAR NAME=ALTTEXT --><br /><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Plan your Trip now...</a></div>
					</div>
					<h3><!-- TMPL_VAR NAME=ADTITLE --></h3>
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/getintouchwithus.gif" width="114" height="114" />
						<div class="hansbold"><!-- TMPL_VAR NAME=ADTEXT --></div>
					</div>
				<!-- /TMPL_IF -->
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

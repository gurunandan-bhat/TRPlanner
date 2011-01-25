<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=<!-- TMPL_VAR NAME=GOOGLEKEY -->" type="text/javascript"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.cycle.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/odysseyhotels.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/hotelsearch.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/favourites.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				<!-- TMPL_VAR NAME=HOTELNAME --> in <!-- TMPL_VAR NAME=HOTELCITYNAME --> - Travel in India | Traveller's Palm
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
					<div id="frameslideshow" thishotel="<!-- TMPL_VAR NAME=HOTELID -->" maxhotelimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_1.jpg" width="560" height="340" alt="" title="" imgsrno="1" imgfile="hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_1.jpg" />
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_2.jpg" width="560" height="340" alt="" title="" imgsrno="2" imgfile="hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_2.jpg" />
					</div>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1><!-- TMPL_VAR NAME=HOTELNAME --></h1>
					<h2>&nbsp;</h2>
					<!-- TMPL_VAR NAME=HOTELDESCRIPTION -->
					<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
				</div>
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a>
							<ul>
								<li><a id="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->state/<!-- TMPL_VAR NAME=THISSTATEURL -->"><!-- TMPL_VAR NAME=THISSTATENAME --></a>
									<ul>
										<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->city/<!-- TMPL_VAR NAME=HOTELCITYURL -->"><!-- TMPL_VAR NAME=HOTELCITYNAME --></a>
											<ul>
												<li><div id="current"> &raquo; <!-- TMPL_VAR NAME=HOTELNAME --> <!-- TMPL_VAR NAME=HOTELCATEGORY --></div></li>
												<!-- TMPL_IF NAME=MODHOTELS -->
												<!-- TMPL_LOOP NAME=MODHOTELS -->
													<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><!-- TMPL_VAR NAME=HOTELNAME --> ($)</a></li>
												<!-- /TMPL_LOOP -->
												<!-- /TMPL_IF -->
											</ul>
											<!-- TMPL_IF NAME=SUPHOTELS -->
												<ul>
												<!-- TMPL_LOOP NAME=SUPHOTELS -->
													<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><!-- TMPL_VAR NAME=HOTELNAME --> ($$)</a></li>
												<!-- /TMPL_LOOP -->
												</ul>
											<!-- /TMPL_IF -->
											<!-- TMPL_IF NAME=LUXHOTELS -->
												<ul>
												<!-- TMPL_LOOP NAME=LUXHOTELS -->
													<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><!-- TMPL_VAR NAME=HOTELNAME --> ($$$)</a></li>
												<!-- /TMPL_LOOP -->
												</ul>
											<!-- /TMPL_IF -->
											<!-- TMPL_IF NAME=TOPHOTELS -->
												<ul>
												<!-- TMPL_LOOP NAME=TOPHOTELS -->
													<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel/<!-- TMPL_VAR NAME=HOTELURL -->"><!-- TMPL_VAR NAME=HOTELNAME --> ($$$$)</a></li>
												<!-- /TMPL_LOOP -->
												</ul>
											<!-- /TMPL_IF -->
										</li>
									</ul>
								</li>
							</ul>
						</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>About <!-- TMPL_VAR NAME=HOTELNAME --></h3>
					<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/hotel_<!-- TMPL_VAR NAME=HOTELID -->_collage.gif" width="470" height="360" />
					<!-- TMPL_VAR NAME=HOTELDETAIL1 -->
					<p class="fav">
						<!-- TMPL_IF NAME=ISFAVOURITE -->
						This Hotel (<!-- TMPL_VAR NAME=HOTELNAME -->) has been added to your favourites. Click <a href='/my-travellers-palm'>here</a> to see all your favourites
						<!-- TMPL_ELSE -->
						<a id="addtofav" "href="#" registered="<!-- TMPL_VAR NAME=REGISTERED -->" type="hotel" objid="<!-- TMPL_VAR NAME=HOTELID -->">Add "<!-- TMPL_VAR NAME=HOTELNAME -->" to your favourites</a>
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
					<hr />
				</div>
				<div class="span-8 rightcol last">
					<!-- TMPL_IF NAME=RELMODS -->
					<h3>Related Trips</h3>
					<!-- TMPL_LOOP NAME=RELMODS -->
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/mod_<!-- TMPL_VAR NAME=ITIN_ID -->_advert.gif" width="114" height="114" />
						<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=ITIN_URL -->"><h4><!-- TMPL_VAR NAME=ITIN_TITLE --></h4></a>
						<strong>(<!-- TMPL_VAR NAME=ITIN_DURATION -->)</strong><br />
						<div class="hansbold"><!-- TMPL_VAR NAME=ITIN_ADV --></div>
					</div>
					<!-- /TMPL_LOOP -->
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
					<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
					<div <!-- TMPL_IF NAME=HIDEMAP -->style="display: none;"<!-- /TMPL_IF -->>
						<h3>About <!-- TMPL_VAR NAME=HOTELCITYNAME --></h3>
						<p><div id="map_canvas" lat="<!-- TMPL_VAR NAME=LATITUDE -->" lng="<!-- TMPL_VAR NAME=LONGITUDE -->" style="width: 310px; height: 400px; overflow: hidden;"></div></p>
						<p class="hotelrightbox"><!-- TMPL_VAR NAME=HOTELCITYDESCRIPTION --></p>
					</div>
					<h3><!-- TMPL_VAR NAME=ALTTITLE --></h3>
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/plantheperfecttrip.gif" width="114" height="114" />
						<div class="hansbold"><!-- TMPL_VAR NAME=ALTTEXT --><br /><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Plan your Trip now...</a></div>
					</div>
					<h3><!-- TMPL_VAR NAME=ADTITLE --></h3>
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/getintouchwithus.gif" width="114" height="114" />
						<div class="hansbold"><!-- TMPL_VAR NAME=ADTEXT --><br /></div>
					</div>
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

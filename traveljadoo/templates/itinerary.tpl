<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/thickbox.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/thickbox.css" type="text/css" media="screen" />
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.cycle.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/itinerary.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/thickbox-compressed.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/favourites.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				<!-- TMPL_VAR NAME=ITINNAME --> - India Tour | Traveller's Palm			
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
					<!-- TMPL_IF NAME=ITINISTOUR -->
					<!-- TMPL_INCLUDE NAME="bannermenu_tours.tpl" -->
					<!-- TMPL_ELSE -->
					<!-- TMPL_INCLUDE NAME="bannermenu_modules.tpl" -->
					<!-- /TMPL_IF -->										
			</div>
			<div class="span-16">
				<div id="imgframe">
					<div id="frameslideshow" itintypedir="<!-- TMPL_VAR NAME=ITINTYPEDIR -->" itintype="<!-- TMPL_VAR NAME=ITINTYPE -->" thisitin="<!-- TMPL_VAR NAME=ITINID -->" maxitinimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/<!-- TMPL_VAR NAME=ITINTYPEDIR -->/<!-- TMPL_VAR NAME=ITINTYPE -->_<!-- TMPL_VAR NAME=ITINID -->_1.jpg" width="560" height="340" alt="" title="" imgsrno="1" imgfile="<!-- TMPL_VAR NAME=ITINTYPE -->_<!-- TMPL_VAR NAME=ITINID -->_1.jpg" />
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/<!-- TMPL_VAR NAME=ITINTYPEDIR -->/<!-- TMPL_VAR NAME=ITINTYPE -->_<!-- TMPL_VAR NAME=ITINID -->_2.jpg" width="560" height="340" alt="" title="" imgsrno="2" imgfile="<!-- TMPL_VAR NAME=ITINTYPE -->_<!-- TMPL_VAR NAME=ITINID -->_2.jpg" />
					</div>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1><!-- TMPL_VAR NAME=ITINNAME --></h1>
					<h2><!-- TMPL_VAR NAME=ITINONELINER --></h2>
					<!-- TMPL_VAR NAME=ITINDESC -->
					<div id="quoteunit">
						<!-- TMPL_VAR NAME=ITINQUOTE -->
					</div>
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
						<li><a <!-- TMPL_IF NAME=REGIONID -->id="toplink"<!-- /TMPL_IF --> href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a>
							<!-- TMPL_IF NAME=REGIONID -->
							<ul>
								<li><a id="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->"><!-- TMPL_VAR NAME=REGIONNAME --></a>
									<ul>
										<li><div id="current"><!-- TMPL_VAR NAME=ITINNAME --></div></li>
										<!-- TMPL_LOOP NAME=OTHERITINS -->
										<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->moduledetails/<!-- TMPL_VAR NAME=OTHERITINURL -->"><!-- TMPL_VAR NAME=OTHERITINNAME --></a></li>
										<!-- /TMPL_LOOP -->
									</ul>
								</li>
							</ul>
							<!-- /TMPL_IF -->
						</li>
						<li><a <!-- TMPL_UNLESS NAME=REGIONID -->id="toplink"<!-- /TMPL_UNLESS --> href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a>
							<!-- TMPL_UNLESS NAME=REGIONID -->
							<ul>
								<li><div id="current"><!-- TMPL_VAR NAME=ITINNAME --></div></li>
								<!-- TMPL_LOOP NAME=OTHERITINS -->
								<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->moduledetails/<!-- TMPL_VAR NAME=OTHERITINURL -->"><!-- TMPL_VAR NAME=OTHERITINNAME --></a></li>
								<!-- /TMPL_LOOP -->
							</ul>
							<!-- /TMPL_UNLESS -->
						</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3><!-- TMPL_VAR NAME=ITINNAME --></h3>
					<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/<!-- TMPL_VAR NAME=ITINTYPEDIR -->/<!-- TMPL_VAR NAME=ITINTYPE -->_<!-- TMPL_VAR NAME=ITINID -->_collage_1.jpg" width="470" height="180" />
					<!-- TMPL_VAR NAME=ITINDETAILS -->
					<p class="addfav"><!-- TMPL_VAR NAME=ADDFAVOURITE --></p>
					<p class="showfav"><!-- TMPL_VAR NAME=SHOWFAVOURITE --></p>
					<p class="addquote"><!-- TMPL_VAR NAME=ADDQUOTE --></p>
					<p class="showquote"><!-- TMPL_VAR NAME=SHOWQUOTE --></p>
					<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/<!-- TMPL_VAR NAME=ITINTYPEDIR -->/<!-- TMPL_VAR NAME=ITINTYPE -->_<!-- TMPL_VAR NAME=ITINID -->_collage_2.jpg" width="470" height="180" />
					<p class="fav">
						<!-- TMPL_IF NAME=ISFAVOURITE -->
						This Itinerary (<!-- TMPL_VAR NAME=ITINNAME -->) has been added to your favourites. Click <a href='/my-travellers-palm'>here</a> to see all your favourites
						<!-- TMPL_ELSE -->
						<a id="addtofav" href="#" registered="<!-- TMPL_VAR NAME=REGISTERED -->" type="itin" objid="<!-- TMPL_VAR NAME=ITINID -->">Add "<!-- TMPL_VAR NAME=ITINNAME -->" to your favourites</a>
						<br />
						<form id="register" method="get" action="#">
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
					<!-- TMPL_IF NAME=ITINISTOUR -->
					<h3>Tour Route</h3>
					<p style="padding-left: 20px;"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/tours/rt_map_<!-- TMPL_VAR NAME=ITINID -->.jpg" height="245" width="269" /></p>
					<!-- TMPL_ELSE -->
					<h3>Tailor-made Suggestions</h3>
					<div>
						<h4 style="text-align: center; color: #a52a2a; margin-bottom: 18px;"><!-- TMPL_VAR NAME=ITINTIPSHEADER --></h4>
						<p class="box"><strong><!-- TMPL_VAR NAME=ITINTIPSINTRO --></strong></p>
					</div>
					<!-- /TMPL_IF -->
					<!-- TMPL_LOOP NAME=ITINTIPS -->
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/mod_<!-- TMPL_VAR NAME=ITINID -->_tip_<!-- TMPL_VAR NAME=__counter__ -->.gif" width="114" height="114" />
						<h4><!-- TMPL_VAR NAME=TIPTITLE --></h4>
						<div class="hansbold"><!-- TMPL_VAR NAME=TIPTEXT --></div>
					</div>
					<hr />
					<!-- /TMPL_LOOP -->
					<h3>Fact Finder for this Tour</h3>
					<div class="box">
						<div class="itinbox">
							<h6>Highlights</h6>
							<!-- TMPL_VAR NAME=ITINHIGHLIGHTS -->
						</div>
						<div class="itinbox">
							<h6>Duration</h6>
							<p><!-- TMPL_VAR NAME=ITINDURATION --></p>
						</div>
						<div class="itinbox">
							<h6>Departure</h6>
							<p><!-- TMPL_VAR NAME=ITINDATES --></p>
						</div>
						<div class="itinbox">
							<h6>Price</h6>
							<p><!-- TMPL_VAR NAME=ITINPRICE --></p>
						</div>
						<div class="itinbox">
							<h6>Inclusions</h6>
							<div><!-- TMPL_VAR NAME=ITININCLUSIONS --></div>
						</div>
					</div>
					<hr />
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

			
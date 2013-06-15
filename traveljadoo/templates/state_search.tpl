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
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=<!-- TMPL_VAR NAME=GOOGLEKEY -->" type="text/javascript"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.jmap.min-r72.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.cycle.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/new_odyssey.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/hotelsearch.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/odyssey_statemap.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/swfobject.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				<!-- TMPL_VAR NAME=STATENAME --> - Tailor Made Holidays in India | Traveller's Palm
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
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/state/state_<!-- TMPL_VAR NAME=STATEID -->_main.jpg" width="560" height="340" />
					</div>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1><!-- TMPL_VAR NAME=STATENAME --></h1>
					<h2><!-- TMPL_VAR NAME=STATEONELINER --></h2>
					<!-- TMPL_VAR NAME=STATEWRITEUP -->
					<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
				</div>
			</div>
			<hr class="space">
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a>
							<ul>
								<li><div id="current"><!-- TMPL_VAR NAME=STATENAME --></div>
								<!-- TMPL_IF NAME=OTHERCITIES -->
								<ul>
									<!-- TMPL_LOOP NAME=OTHERCITIES -->
									<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->city/<!-- TMPL_VAR NAME=OTHERCITYURL -->"><!-- TMPL_VAR NAME=OTHERCITYNAME --></a></li>
									<!-- /TMPL_LOOP -->
								</ul>
								<!-- /TMPL_IF -->
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
					<h3><!-- TMPL_VAR NAME=STATENAME --></h3>
					<div class="box">
						<div id="big_map" style="width: 460px; height: 280px;" lat="<!-- TMPL_VAR NAME=LATITUDE -->" lng="<!-- TMPL_VAR NAME=LONGITUDE -->" thiscity="<!-- TMPL_VAR NAME=CURRID -->"></div>
					</div>
					<!-- TMPL_VAR NAME=STATEWEBWRITEUP -->
					<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/state/state_<!-- TMPL_VAR NAME=STATEID -->_large_1.jpg" width="470" height="180" />
				</div>
				<div class="span-8 rightcol last">
					<h3 style="margin-bottom: 0;">Use this Map to Navigate</h3>
					<div id="flashcontent" style="width: 210px; height: 280px; border-left: 50px solid #aeaeae; border-right: 50px solid #aeaeae; border-top: 25px solid #aeaeae; border-bottom: 25px solid #aeaeae; margin: 0px;">Upgrade Your Flash Player</div>
					<!-- TMPL_IF NAME=RELMODS -->
						<h3>Related Trips</h3>
						<!-- TMPL_LOOP NAME=RELMODS -->
						<div class="box">
							<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/modules/mod_<!-- TMPL_VAR NAME=ITIN_ID -->_advert.gif" width="114" height="114" />
							<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=ITIN_URL -->"><h4><!-- TMPL_VAR NAME=ITIN_TITLE --></h4></a>
							<strong>(<!-- TMPL_VAR NAME=ITIN_DURATION -->)</strong><br />
							<div class="hansbold"><!-- TMPL_VAR NAME=ITIN_ADV --></div>
						</div>
						<hr class="space" />
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
						<hr class="space" />
						<!-- /TMPL_LOOP -->
					<!-- /TMPL_IF -->
					<h3><!-- TMPL_VAR NAME=ALTTITLE --></h3>
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/plantheperfecttrip.gif" width="114" height="114" />
					</div>
					<h3><!-- TMPL_VAR NAME=ADTITLE --></h3>
					<div class="box">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/getintouchwithus.gif" width="114" height="114" />
						<div class="hansbold"><!-- TMPL_VAR NAME=ADTEXT --></div>
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
		<script type="text/javascript">
			var so = new SWFObject("/maps/ammap.swf", "ammap", "100%", "100%", "8", "#ffffff");
    		so.addVariable("path", "/maps/");
			so.addVariable("data_file", escape("/maps/ammap_data_<!-- TMPL_VAR NAME=STATEID  -->.xml"));
    		so.addVariable("settings_file", escape("/maps/ammap_settings.xml"));		
			so.addVariable("preloader_color", "#999999");
			so.write("flashcontent");
		</script>
	</body>
</html>

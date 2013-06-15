<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				People behind Travellers Palm | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_aboutus.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content-leftsided">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li>Home</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">India Journeys</a></li>
						<li><a id="toplink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->about-us">About Us</a>
							<ul>
								<li><a class="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->meet-the-team">Meet the Team</a></li>
								<li><!-- TMPL_IF NAME=WHYTRAVEL --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->why-travel-with-us"><!-- /TMPL_IF -->Why Travel with Us?<!-- TMPL_IF NAME=WHYTRAVEL --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=RESPTRAVEL --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->responsible-travel"><!-- /TMPL_IF -->Responsible Travel<!-- TMPL_IF NAME=RESPTRAVEL --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=WHATEXPECT --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->what-to-expect"><!-- /TMPL_IF -->What to Expect<!-- TMPL_IF NAME=WHATEXPECT --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=BEFORETRAVEL --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->before-you-go"><!-- /TMPL_IF -->Before You Go<!-- TMPL_IF NAME=BEFORETRAVEL --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=HOWTOPLAN --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="<!-- TMPL_VAR NAME=BASEPREFIX -->how-to-plan-your-trip"><!-- /TMPL_IF -->How to Plan your Trip<!-- TMPL_IF NAME=HOWTOPLAN --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
							</ul>
						</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<div class="people">
						<h3>Meet our Team</h3>
						<!-- TMPL_LOOP NAME=CONSULTANTS -->
						<p><img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/consultants/consultant_<!-- TMPL_VAR NAME=ID -->.jpg" width="240" height="150" alt="<!-- TMPL_VAR NAME=NAME -->" /></p>
						<div style="width: 210px; float: right;">
							<h1><!-- TMPL_VAR NAME=NAME --></h1>
							<p><!-- TMPL_VAR NAME=WRITEUP --></p>
						</div>
						<hr />
						<!-- /TMPL_LOOP -->
					</div>
				</div>
				<div class="span-8 rightcol last">
					<script src="http://www.clocklink.com/embed.js"></script>
					<script type="text/javascript" language="JavaScript">obj=new Object;obj.clockfile="5025-white.swf";obj.TimeZone="GMT+0530";obj.width=180;obj.height=180;obj.wmode="transparent";showClock(obj);</script><br />
					<a href="http://www.wunderground.com/global/stations/43192.html?bannertypeclick=infobox">
						<img src="http://weathersticker.wunderground.com/weathersticker/infobox_both/language/www/global/stations/43192.gif" alt="Click for Goa, India Forecast" border="0" height="108" width="144" />
					</a>
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
			

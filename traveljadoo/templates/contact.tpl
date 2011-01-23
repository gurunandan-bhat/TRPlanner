<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				Contact Us | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_contact.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/contactus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content" style="background: none;">
				<div class="span-16 midcol">
					<h3>Traveller's Palm Contact Information</h3>
					<div class="prepend-4 span-12 last">
						<div id="contact">
						<!-- TMPL_VAR NAME=WRITEUP -->
						<p style="font-size: 10px; font-style: italic;"><!-- TMPL_VAR NAME=LEGALESE --></p>
						</div>
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

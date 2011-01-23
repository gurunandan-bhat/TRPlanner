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
				About Us | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_aboutus.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/banners/banner_<!-- TMPL_VAR NAME=WEBID -->.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->">Home</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes">Incredible India</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places">Special Places</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules">Mini Itineraries</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a></li>
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
						</li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3><!-- TMPL_VAR NAME=TITLE --></h3>
					<div id="contact">
					<!-- TMPL_VAR NAME=WRITEUP -->
					</div>
					<hr />
				</div>
				<div class="span-8 rightcol last">
					<!-- TMPL_IF NAME=TEXTINDEX -->
					<h3>Quick Navigator</h3>
					<!-- TMPL_INCLUDE NAME=before_you_go_index.tpl -->
					<!-- TMPL_ELSE -->
					<h3><!-- TMPL_VAR NAME=RIGHTHDR --></h3>
					<!-- TMPL_LOOP NAME=SIDEITEMS -->
					<div class="box" style="margin-bottom: 0;">
						<img class="left" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/aboutus/aboutus_sidebar_<!-- TMPL_VAR NAME=SIDEITEMID -->.gif" width="114" height="114" />
						<h4><!-- TMPL_VAR NAME=SIDEITEMTITLE --></h4>
						<div class="hansbold"><!-- TMPL_VAR NAME=SIDEITEMTEXT --></div>
					</div>
					<!-- /TMPL_LOOP -->
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

			
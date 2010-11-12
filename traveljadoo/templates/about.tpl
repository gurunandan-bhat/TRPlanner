<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
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
				<img src="images/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="/">Home</a></li>
						<li><a href="/themes">Incredible India</a></li>
						<li><a href="/special_places">Special Places</a></li>
						<li><a href="/modules">Mini Itineraries</a></li>
						<li><a href="/tours">India Journeys</a></li>
						<li><div id="current"><a id="toplink" href="/about-us">About Us</a></div>
							<ul>
								<li><a class="midlink" href="/meet-the-team">Meet the Team</a></li>
								<li><!-- TMPL_IF NAME=WHYTRAVEL --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="/why-travel-with-us"><!-- /TMPL_IF -->Why Travel with Us?<!-- TMPL_IF NAME=WHYTRAVEL --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=RESPTRAVEL --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="/responsible-travel"><!-- /TMPL_IF -->Responsible Travel<!-- TMPL_IF NAME=RESPTRAVEL --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=WHATEXPECT --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="/what-to-expect"><!-- /TMPL_IF -->What to Expect<!-- TMPL_IF NAME=WHATEXPECT --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=BEFORETRAVEL --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="/before-you-go"><!-- /TMPL_IF -->Before You Go<!-- TMPL_IF NAME=BEFORETRAVEL --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
								<li><!-- TMPL_IF NAME=HOWTOPLAN --><div id="current"><!-- TMPL_ELSE--><a class="midlink" href="/how-to-plan-your-trip"><!-- /TMPL_IF -->How to Plan your Trip<!-- TMPL_IF NAME=HOWTOPLAN --></div><!-- TMPL_ELSE--></a><!-- /TMPL_IF --></li>
							</ul>
						</li>
						<li><a href="/contact-us">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3>About Us</h3>
					<!-- TMPL_VAR NAME=ABOUTODC -->
					<hr />
				</div>
				<div class="span-8 rightcol last">
					<h3>Meet our Team</h3>
					<div class="box">
						<img src="images/team.jpg" width="280" height="137" alt="Team Odyssey" />
						<p><!-- TMPL_VAR NAME=ABOUTTEAM --><br /><br /><a href="/meet-the-team">Read more about our Team</a></p>
					</div>
					<h3>Traveller's Palm</h3>
					<div class="box" style="font-style: italic;"><!-- TMPL_VAR NAME=ABOUTTP --></div>
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

			
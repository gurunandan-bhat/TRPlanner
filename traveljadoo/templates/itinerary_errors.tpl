<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/cmxform.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/blk.js"></script>
		<title>Your Itinerary</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->
			</div>
			<div class="span-24 last">
				<img src="images/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="index.cgi">Home</li>
						<li><a href="theme.cgi">Themes</a></li>
						<li><a href="hotel.cgi">Special Places</a></li>
						<li><a href="region.cgi">Modules</a></li>
						<li><a href="tours.cgi">Tours</a></li>
						<li><a href="index.cgi?mode=about">About Us</a></li>
						<li><a href="index.cgi?mode=contact">Contact Us</a></li>
					</ul>
				</div>
				<div class="span-12 midcol">
					<h3><!-- TMPL_VAR NAME=TITLE --></h3>
					<!-- TMPL_VAR NAME=TEXT1 -->
					<table>
						<tr><th>Day-to-Day Itinerary</th></tr>
						<!-- TMPL_LOOP NAME=SUMMARY -->
						<tr>
							<td><h2>Day <!-- TMPL_VAR NAME=DAYNUM --> (<!-- TMPL_VAR NAME=DATE -->), <!-- TMPL_VAR NAME=CITY --></h2><!-- TMPL_VAR NAME=DETAIL --></td>
						</tr>
						<!-- /TMPL_LOOP -->
					</table>
					<form action="travel.cgi" class="cmxform" method="post">
						<fieldset>
							<legend>Special Requests</legend>
							<p><!-- TMPL_VAR NAME=TEXT2 --></p>
							<ol>
								<li><label for="sprequest" style="-moz-inline-box">Request: <textarea id="sqrequest" name="sqrequest" cols="25" rows="7"></textarea></label></li>
							</ol>
						</fieldset>
						<input type="hidden" name="mode" value="send_email" />
						<p><!-- TMPL_VAR NAME=TEXT3 --></p>
						<p><input type="image" src="images/proceed-to-quote.gif" width="203" height="25" value="Proceed with my Quote Request" /></p>
					</form>
					<div style="display: none;">
						<h1 style="margin-top: 10px;">Detailed Itinerary</h1>
						<table>
							<tr><th>Milestones in your Journey</th></tr>
							<!-- TMPL_LOOP NAME=DETAILS -->
							<tr>
								<td><h1>Day <!-- TMPL_VAR NAME=DAYNUM -->: <!-- TMPL_VAR NAME=HEADER --></h1><h2><!-- TMPL_VAR NAME=DATE --> <!-- TMPL_VAR NAME=CITY --></h2><!-- TMPL_VAR NAME=DETAIL --></td>
							</tr>
							<!-- /TMPL_LOOP -->
						</table>
					</div>
				</div>
				<div class="span-8 rightcol last">
				</div>
			</div>
		</div>
	</body>
</html>

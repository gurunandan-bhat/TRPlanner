<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/cmxform.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<title>Your Itinerary</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Quick Links</h3>
					<ul>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->index.cgi">Home</li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->theme.cgi">Themes</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel.cgi">Special Places</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->region.cgi">Modules</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours.cgi">Tours</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->index.cgi?mode=about">About Us</a></li>
						<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->index.cgi?mode=contact">Contact Us</a></li>
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
					<form action="<!-- TMPL_VAR NAME=BASEPREFIX -->travel.cgi" class="cmxform" method="post">
						<fieldset>
							<legend>Special Requests</legend>
							<p><!-- TMPL_VAR NAME=TEXT2 --></p>
							<ol>
								<li><label for="sprequest" style="-moz-inline-box">Request: <textarea id="sqrequest" name="sqrequest" cols="25" rows="7"></textarea></label></li>
							</ol>
						</fieldset>
						<input type="hidden" name="mode" value="send_email" />
						<p><!-- TMPL_VAR NAME=TEXT3 --></p>
						<p><input type="image" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/proceed-to-quote.gif" width="203" height="25" value="Proceed with my Quote Request" /></p>
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

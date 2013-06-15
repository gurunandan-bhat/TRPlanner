<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<title>Odyssey: Module Log</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
			</div>
			<div class="column span-24 last city">
				<div class="column span-16">
					<div id="slideshow" class="mainimg">
						<img src="images/style/dalailama.jpg" width="600" height="370" alt="Errors are Fun, No?" />
					</div>
				</div>
				<div class="column span-8 last description">
					<h1>Amend Your Tour Itinerary</h1>
					<h2>Choose an Itinerary to Amend</h2>
					<p>The table on the left below shows the last 15 Quotations generated on our site. Click on the Quotation that you want to amend.</p>
				</div>
			</div>
			<div class="column span-16 append-8 last quotelist">
				<div class="quotelist">
					<h1>Recent Quotations</h1>
					<p>Click on Party Name to edit Itinerary</p>
					<table width="100%">
						<tr><th>Quote No.</th><th>Party Name</th><th>Arrival Date</th><th>Start Date</th></tr>
						<!-- TMPL_LOOP NAME=QUOTES -->
						<tr<!-- TMPL_UNLESS NAME=__odd__ --> class="even"<!-- /TMPL_UNLESS -->>
							<td><!-- TMPL_VAR NAME=QUOTEID --></td>
							<td><a href="edit.cgi?mode=listtour&quoteid=<!-- TMPL_VAR NAME=QUOTEID -->"><!-- TMPL_VAR NAME=PAXNAME --></a></td>
							<td><!-- TMPL_VAR NAME=ARRDATE --></td>
							<td><!-- TMPL_VAR NAME=STARTDATE --></td>
						</tr>
						<!-- /TMPL_LOOP -->
					</table>
				</div>
			</div>
		</div>
	</body>
</html>

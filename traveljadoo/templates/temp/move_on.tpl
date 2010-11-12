<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="js/jquery.cycle.pack.js"></script>
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true&amp;key=ABQIAAAANNgAl6Yk0J_LHL8ee--iiBRKRT3lEAXbWt9bKSuE5xGrJNjhaBSmYrPob9NYNAyq2W3hgzWgqsVk9g" type="text/javascript"></script>
		<script type="text/javascript" src="js/jquery.jmap.min-r72.js"></script>
		<script type="text/javascript" src="js/odyssey.js"></script>
		<script type="text/javascript" src="js/odyssey_map.js"></script>
		<title>Odyssey Tours: <!-- TMPL_VAR NAME=CURRNAME --></title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="column span-24 last city">
				<div class="column span-16">
					<div id="big_map" style="width: 600px; height: 370px; padding-left: 15px" lat="<!-- TMPL_VAR NAME=LATITUDE -->" lng="<!-- TMPL_VAR NAME=LONGITUDE -->" thiscity="<!-- TMPL_VAR NAME=CURRID -->"></div>
				</div>
				<div class="column span-8 last description">
					<h1>Your Tour Status</h1>
					<p>The Date is <strong><!-- TMPL_VAR NAME=DEPDATE --> - Day <!-- TMPL_VAR NAME=DEPDAYNUM --></strong> of your Tour.<br /><br />
					You are currently in <strong><!-- TMPL_VAR NAME=DEPCITYNAME --></strong> and ready to leave. You are considering cities around <strong><!-- TMPL_VAR NAME=DEPCITYNAME --></strong>
					for your next destination.<br /><br />
					On the left, you can see the map which <strong>highlights destinations near <!-- TMPL_VAR NAME=CURRNAME --></strong>.<br /><br /> 
					Below the map, we have listed the <strong>most popular destinations from <!-- TMPL_VAR NAME=CURRNAME --></strong> with a note on what makes each of them special.<br /><br /> 
					Alternatively, you can choose to go to any other city by selecting from the various options listed:
					<form class="nextcity" method="post" action="travel.cgi">
						<p><label for="desturl">Try out your next Destination: </label> 
							<select id="desturl" name="desturl">
							<!-- TMPL_LOOP NAME=RANDOMDESTINATION -->
								<option value="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=RANDOMDESTID -->"><!-- TMPL_VAR NAME=RANDOMDESTNAME --></option>
							<!-- /TMPL_LOOP -->
							</select>
							<input type="submit" value="Go!" />
							<input type="hidden" name="mode" value="randomcity" />
						</p>
					</form>
					</p>
				</div>
			</div>
			<div class="column span-16">
				<div class="moveon">
					<div class="intro">
						<h1>Interesting Places to go to from <!-- TMPL_VAR NAME=CURRNAME --></h1>
						<p>Experienced travellers recommend the following places as great destinations from <!-- TMPL_VAR NAME=CURRNAME -->.</p>
					</div>
					<!-- TMPL_LOOP NAME=NEARCITIES -->					
					<div class="option">
						<h1><a href="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=ID -->"><!-- TMPL_VAR NAME=NAME --></a></h1>
						<h2><!-- TMPL_VAR NAME=ONLINER --></h2> 
						<p><img src="images/city_<!-- TMPL_VAR NAME=ID -->_movingon.jpg" width="240" height="150" alt="<!-- TMPL_VAR NAME=NAME -->" /> 
						<!-- TMPL_VAR NAME=WRITEUP -->
						<a href="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=ID -->">Read more about <!-- TMPL_VAR NAME=NAME --> &raquo;</a></p>
					</div>
					<!-- /TMPL_LOOP -->
				</div>
			</div>
			<div class="column span-8 last self">
				<div class="mapcontainer">
					<!-- TMPL_IF NAME=SUMMARY -->
						<h1><!-- TMPL_VAR NAME=PAXNAME -->'s Custom Tour Plan</h1>
						<p>You have saved the following Tour Plan. <a href="index.cgi?mode=restart" target="_blank">Click Here</a> if you want to see the details 
						of your saved itinerary (opens details in a separate window).</p>
						<!-- TMPL_VAR NAME=SUMMARY -->
						<h1>Want to end your tour?</h1>
						<p><a href="travel.cgi?mode=end_tour">Yes! End my tour now at <!-- TMPL_VAR NAME=CURRNAME --></a></p>
						<p class="notice">In case you want to start afresh, just fill in the form <a href="index.cgi?mode=init">here</a>. Note that your current tour plan will be erased 
						in case you choose to start afresh.</p>
					<!-- TMPL_ELSE -->
						<h1>Welcome Gentle Traveler</h1>
						<p>We have no record of your Tour. To build your tour, we first need some information. <a href="index.cgi?mode=init">Click here</a> to start planning tour".</p>
					<!-- /TMPL_IF -->
				</div>
			</div>
		</div>
	</body>
</html>

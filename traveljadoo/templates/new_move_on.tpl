<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="js/jquery.cycle.lite.min.js"></script>
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAANNgAl6Yk0J_LHL8ee--iiBQ-De2rHpQRn1piwxGxvGxlLqTVjhQZvcv_Q12H7pOROmKF7va9pvfVqw" type="text/javascript"></script>
		<script type="text/javascript" src="js/odyssey.js"></script>
		<script type="text/javascript" src="js/jquery.jmap.min-r72.js"></script>
		<script type="text/javascript" src="js/odyssey_map.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<title>The Traveller's Palm: <!-- TMPL_VAR NAME=CURRNAME --></title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_planatrip.tpl" -->
			</div>
			<div class="span-16">
				<div id="imgframe">
					<div id="frameslideshow">
						<div id="big_map" style="width: 560px; height: 340px;" lat="<!-- TMPL_VAR NAME=LATITUDE -->" lng="<!-- TMPL_VAR NAME=LONGITUDE -->" thiscity="<!-- TMPL_VAR NAME=CURRID -->"></div>
					</div>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1>Your Tour Status</h2>
					<h2>The Date is <!-- TMPL_VAR NAME=DEPDATE --> - Day <!-- TMPL_VAR NAME=DEPDAYNUM --> of your Tour.</h2>
					<p>You are currently in <strong><!-- TMPL_VAR NAME=DEPCITYNAME --></strong> and ready to leave.</p>
					<p>You are considering cities around <strong><!-- TMPL_VAR NAME=DEPCITYNAME --></strong> for your next destination.</p>
					<p>On the left, you can see the map which <strong>highlights destinations near <!-- TMPL_VAR NAME=CURRNAME --></strong>.</p>
					<p>Below the map, we have listed the <strong>most popular destinations from <!-- TMPL_VAR NAME=CURRNAME --></strong> 
					with a note on what makes each of them special.</p> 
					<!-- TMPL_INCLUDE NAME=new_randomcityform.tpl -->
				</div>
			</div>
			<hr class="space" />
			<div class="content" style="background: none;">
			<div style="background: url('images/plantrip_bg.gif') repeat-y; float: left;">
				<div class="prepend-1 span-12 append-1 midcol">
					<h3>Interesting Places to go to from <!-- TMPL_VAR NAME=CURRNAME --></h3>
					<!-- TMPL_LOOP NAME=NEARCITIES -->					
					<p class="imgholder"><img class="left" src="images/city_<!-- TMPL_VAR NAME=ID -->_movingon.jpg" width="220" height="138" /></p>
					<a href="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=ID -->"><h4><!-- TMPL_VAR NAME=NAME --></h4></a>
					<h5><!-- TMPL_VAR NAME=ONELINER --></h5> 
					<p><!-- TMPL_VAR NAME=WRITEUP --><br />
					<a href="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=ID -->">Read more about <!-- TMPL_VAR NAME=NAME --> &raquo;</a></p>
					<hr />
					<!-- /TMPL_LOOP -->
				</div>
				<div class="span-9 rightcol append-1 last">
					<div class="rightsection">
						<!-- TMPL_IF NAME=SUMMARY -->
						<h3>Tour Plan for <!-- TMPL_VAR NAME=PAXNAME --></h3>
						<div class="box">
							<p>You have saved the following Tour Plan.</p>
							<!-- TMPL_VAR NAME=SUMMARY -->
							<p class="notice">In case you want to start afresh, just fill in the form <a href="index.cgi?mode=init">here</a>. Note that your current tour plan will be erased 
							in case you choose to start afresh.</p>
							<hr />
							<h4>Want to end your tour?</h4>
							<p>Yes, <a href="travel.cgi?mode=end_tour">end my tour</a> at <!-- TMPL_VAR NAME=CURRNAME --></p>
						</div>
						<!-- TMPL_ELSE -->
						<div class="box">
							<h3>Welcome Gentle Traveler</h3>
							<p>We have no record of your Tour. To build your tour, we first need some information. <a href="index.cgi?mode=init">Click here</a> to start planning tour".</p>
						</div>
						<!-- /TMPL_IF -->
						</div>
					</div>
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
	</body>
</html>

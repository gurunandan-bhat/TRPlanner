<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/thickbox.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="js/jquery.cycle.lite.min.js"></script>
		<script type="text/javascript" src="js/new_odyssey.js"></script>
		<script type="text/javascript" src="js/thickbox-compressed.js"></script>
		<script type="text/javascript" src="js/otheroptions.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<title>The Travellers Palm: <!-- TMPL_VAR NAME=CURRNAME --></title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_planatrip.tpl" -->
			</div>
			<div class="span-16 frame">
				<div id="imgframe">
					<div id="frameslideshow" thiscity="<!-- TMPL_VAR NAME=CURRID -->" maxcityimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
						<img src="images/city_<!-- TMPL_VAR NAME=CURRID -->_large_1.jpg" width="560" height="340" alt="1" />
						<img src="images/city_<!-- TMPL_VAR NAME=CURRID -->_large_2.jpg" width="560" height="340" alt="2" />
					</div>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="writeup">
					<h1>About <!-- TMPL_VAR NAME=CURRNAME --></h1>
					<h2><!-- TMPL_VAR NAME=CURRONELINER --></h2>
					<!-- TMPL_VAR NAME=CURRWRITEUP -->
					<!-- TMPL_UNLESS NAME=STARTINGPOINT -->
					<p class="success">The Date is <strong><!-- TMPL_VAR NAME=DEPDATE --> - Day <!-- TMPL_VAR NAME=DEPDAYNUM --></strong> of your Tour.
					You are currently in <strong><!-- TMPL_VAR NAME=DEPCITYNAME --></strong> and ready to leave.<br />You are considering <strong><!-- TMPL_VAR NAME=CURRNAME --></strong> 
					as your next destination</p>
					<!-- /TMPL_UNLESS -->
				</div>
			</div>
			<hr class="space">
			<div class="content" style="background: none;">
			<div style="background: url('images/plantrip_bg.gif') repeat-y; float: left;">
				<div class="prepend-1 span-12 midcol append-1">
					<h3>Special Places in <!-- TMPL_VAR NAME=CURRNAME --></h3>
					<p class="imgholder"><img class="left" src="images/defaulthotel_<!-- TMPL_VAR NAME=DEFAULTHOTELID -->.jpg" width="220" height="150" /></p>
					<h4><!-- TMPL_VAR NAME=DEFAULTHOTELNAME --> (<!-- TMPL_VAR NAME=DEFAULTHOTELCOSTCATEGORY -->)</h4>
					<p><!-- TMPL_VAR NAME=DEFAULTHOTELDESCRIPTIONSMALL --></p>
					<p><a href="hotel.cgi?mode=minidescribe&id=<!-- TMPL_VAR NAME=DEFAULTHOTELID -->&height=550&width=420" title="A Peep into our Hotels" class="thickbox">Read More &raquo;</a></p>
					<hr />
					<!-- TMPL_LOOP NAME=OTHERHOTELS -->
					<p class="imgholder"><img class="left" src="images/defaulthotel_<!-- TMPL_VAR NAME=HOTELID -->.jpg" width="220" height="150" /></p>
					<h4><!-- TMPL_VAR NAME=HOTELNAME --> (<!-- TMPL_VAR NAME=HOTELCATEGORY -->)</h4>
					<p><!-- TMPL_VAR NAME=HOTELDESCRIPTION --></p>
					<p><a href="hotel.cgi?mode=minidescribe&id=<!-- TMPL_VAR NAME=HOTELID -->&height=550&width=420" title="A Peep into our Hotels" class="thickbox">Read More &raquo;</a></p>
					<hr />
					<!-- /TMPL_LOOP -->
					<h3>Things To See and Do in <!-- TMPL_VAR NAME=CURRNAME --></h3>
					<img src="images/city_<!-- TMPL_VAR NAME=CURRID -->_collage_1.gif" width="470" height="514" alt="Image Not Available" />
					<!-- TMPL_VAR NAME=CURRWEBWRITEUP -->
				</div>
				<div class="span-9 rightcol append-1 last">
					<div class="rightsection">
						<!-- TMPL_IF NAME=STARTINGPOINT -->
						<h3>Welcome. Your First Stop: <!-- TMPL_VAR NAME=CURRNAME --></h3>
						<!-- TMPL_ELSE -->
						<h3>Yes, I want to Stay in <!-- TMPL_VAR NAME=CURRNAME --></h3>
						<p class="box">
							If you want to visit <!-- TMPL_VAR NAME=CURRNAME --> please enter your preferences here. We have chosen the best options for you. Feel free to change them if you wish
						 	and click on "Submit".
						</p>
						<!-- /TMPL_IF -->
						<div class="box">
							<div class="cityform">
								<form method=post action="<!-- TMPL_VAR NAME=BASEPREFIX -->travel.cgi">
									<p>I want to stay in <!-- TMPL_VAR NAME=CURRNAME --> for 
										<select class="optdays" name="days" size="1">
											<!-- TMPL_LOOP NAME=DAYSLOOP -->
											<option<!-- TMPL_IF NAME=DAYSELECTED --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=DAYVALUE --></option>
											<!-- /TMPL_LOOP --> 
										</select>
										day(s)
									</p>
									<p>I would like to stay at the 
										<select class="opthotel" name="hotel" size="1">
											<option value="<!-- TMPL_VAR NAME=DEFAULTHOTELID -->" selected="selected"><!-- TMPL_VAR NAME=DEFAULTHOTELNAME --></option>
											<!-- TMPL_LOOP NAME=OTHERHOTELS -->
											<option value="<!-- TMPL_VAR NAME=HOTELID -->"><!-- TMPL_VAR NAME=HOTELNAME --></option>
											<!-- /TMPL_LOOP -->
										</select>
									</p>
									<!-- TMPL_IF NAME=STARTINGPOINT -->
										<p>You have chosen to start your tour from <!-- TMPL_VAR NAME=CURRNAME -->. We will provide you with transport to reach your Hotel.</p>
										<input type="hidden" name="travelopts" value="1" />
									<!-- TMPL_ELSE -->
										<p>Here is our recommended way to travel <strong>from</strong> <!-- TMPL_VAR NAME=FROMNAME --> <strong>to</strong> <!-- TMPL_VAR NAME=CURRNAME -->:</p>
										<!-- TMPL_VAR NAME=ROUTEOPTIONS -->
									<!-- /TMPL_IF -->
									<input type="hidden" name="mode" value="transit" />
									<input type="hidden" name="city" value="<!-- TMPL_VAR NAME=CURRID -->" />
									<p class="submit"><input type="submit" value="Take me to <!-- TMPL_VAR NAME=CURRNAME -->!" /></p>
								</form>
							</div>
						</div>
						<!-- TMPL_UNLESS NAME=STARTINGPOINT -->
						<h3>No, Show me other places around <!-- TMPL_VAR NAME=FROMNAME --></h3>
						<div class="box">
							<ul>
								<!-- TMPL_LOOP NAME=NEARCITIES -->
								<li><h4><a href="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=FROMID -->&destid=<!-- TMPL_VAR NAME=PREID -->"><!-- TMPL_VAR NAME=PRENAME --></a></h4></li>
								<!-- /TMPL_LOOP -->
							</ul>
							<form class="nextcity" method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->travel.cgi">
								<p><label for="desturl">Or other places further away: </label> 
									<select id="desturl" name="desturl">
									<!-- TMPL_LOOP NAME=RANDOMDESTINATION -->
										<option value="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=FROMID -->&destid=<!-- TMPL_VAR NAME=RANDOMDESTID -->"><!-- TMPL_VAR NAME=RANDOMDESTNAME --></option>
									<!-- /TMPL_LOOP -->
									</select>
									<input type="submit" value="Go!" />
									<input type="hidden" name="mode" value="randomcity" />
								</p>
							</form>
							<p>Or <a href="travel.cgi?mode=end_tour">End my tour now</a> at <!-- TMPL_VAR NAME=FROMNAME --></p>					
						</div>
						<!-- /TMPL_UNLESS -->
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

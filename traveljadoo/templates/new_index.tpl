<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print">	
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/tp_home.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.cycle.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/new_hpage.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/hotelsearch.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				Traveller's Palm - India Unfolded
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24">
				<!-- TMPL_INCLUDE NAME="new_bannermenu.tpl" -->
			</div>
			<div class="span-16">
				<div id="imgstack">
					<div id="slideshow" maxhomeimages="<!-- TMPL_VAR NAME=MAXHOMEIMAGES -->">
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/hp_1.jpg" width="560" height="325" alt="1" />
						<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/hp_2.jpg" width="560" height="325" alt="2" />
					</div>
				</div>
			</div>
			<div class="span-8 last">
				<div id="writeup">
					<h1 style="padding: 12px 0;"><!-- TMPL_VAR NAME=TITLE --></h1>
					<div id="homepage"><!-- TMPL_VAR NAME=WRITEUP --></div>
				</div>
			</div>
			<div class="span-16 tagline">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/tailormade.jpg" width="630" height="60" alt="Tailormade Holidays in India" />
			</div>
			<div class="span-8 last">
				<!-- TMPL_INCLUDE NAME="new_hotelsearchform.tpl" -->					
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<!-- TMPL_INCLUDE NAME=intro_menu.tpl -->
				</div>
				<div class="span-12 midcol">
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes"><!-- TMPL_VAR NAME=DISCOVERTITLE --></a></h3>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/home_collage_1.jpg" width="470" height="180" style="margin-bottom: 10px;" /></a>
					<!-- TMPL_VAR NAME=DISCOVERBODY -->
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places"><!-- TMPL_VAR NAME=CHECKOUTTITLE --></a></h3>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->special_places"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/home_collage_2.jpg" width="470" height="180" style="margin-bottom: 10px;" /></a>
					<!-- TMPL_VAR NAME=CHECKOUTBODY -->
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules"><!-- TMPL_VAR NAME=INSPIRATIONTITLE --></a></h3>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/home_collage_3.jpg" width="470" height="180" style="margin-bottom: 10px;" /></a>
					<!-- TMPL_VAR NAME=INSPIRATIONBODY -->
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours"><!-- TMPL_VAR NAME=FOLLOWTITLE --></a></h3>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/home_collage_4.jpg" width="470" height="180" style="margin-bottom: 10px;" /></a>
					<!-- TMPL_VAR NAME=FOLLOWBODY -->
				</div>
				<div class="span-8 rightcol last">
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->why-travel-with-us"><!-- TMPL_VAR NAME=RT1TITLE --></a></h3>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->why-travel-with-us"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/homepage_advert_1.gif" class="left" width="114" height="114" style="float: left; padding-top: 10px;" /></a>
					<div class="box" style="background: #e6e2df; width: 170px; clear: none;"><!-- TMPL_VAR NAME=RT1BODY --></div>
					<h3><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/frontiers-of-india"><!-- TMPL_VAR NAME=RT2TITLE --></a></h3>
					<a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/frontiers-of-india"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/homepage_advert_2.gif" class="left" width="114" height="114" style="float: left; padding-top: 10px;" /></a>
					<div class="box" style="background: #e6e2df; width: 170px; clear: none;"><!-- TMPL_VAR NAME=RT2BODY --></div>
					<h3><!-- TMPL_VAR NAME=RT3TITLE --></h3>
					<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/homepage_advert_3.gif" class="left" width="114" height="114" style="float: left; padding-top: 10px;" />
					<div class="box" style="background: #e6e2df; width: 170px; clear: none;"><!-- TMPL_VAR NAME=RT3BODY --></div>
					<h3><a href="http://solita.co.in"><!-- TMPL_VAR NAME=RT4TITLE --></a></h3>
					<a href="http://solita.co.in"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/homepage_advert_4.gif" class="left" width="114" height="114" style="float: left; padding-top: 10px;" /></a>
					<div class="box" style="background: #e6e2df; width: 170px; clear: none;"><!-- TMPL_VAR NAME=RT4BODY --></div>
					<h3><a href="http://solita.co.in"><!-- TMPL_VAR NAME=RT6TITLE --></a></h3>
					<a href="http://solita.co.in"><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/homepage_stoppress.gif" class="left" width="114" height="114" style="float: left; padding-top: 10px;" /></a>
					<div class="box" style="background: #e6e2df; width: 170px; clear: none;"><!-- TMPL_VAR NAME=RT6BODY --></div>
					<h3><a href="http://www.travellers-palm.blogspot.com/"><!-- TMPL_VAR NAME=RT5TITLE --></a></h3>
					<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/home/homepage_advert_5.gif" class="left" width="114" height="114" style="float: left; padding-top: 10px;" />
					<div class="box" style="background: #e6e2df; width: 170px; clear: none;">
						<!-- TMPL_VAR NAME=RT5BODY -->
						<hr class="space" />
						<p>
							<a href="http://facebook.com/#!/pages/Travellers-Palm/152821658071605?ref=ts/" target="_blank"><img src="images/facebook.png" width="24" height="24" alt="facebook" /></a>
							<a href="http://flickr.com/photos/travellers-palm/sets/" target="_blank"><img src="images/flickr.png" width="24" height="24" alt="flickr" /></a>
							<a href="http://travellers-palm.blogspot.com/" target="_blank"><img src="images/blogger.png" width="24" height="24" alt="blogger" /></a>
							<a href="http://twitter.com/travellers_palm" target="_blank"><img src="images/twitter.png" width="24" height="24" alt="twitter" /></a>
							<!-- <a href="http://youtube.com/user/mytravellerspalm" target="_blank"><img src="images/youtube.png" width="24" height="24" alt="youtube.com" /></a> -->
						</p>
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

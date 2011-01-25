<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>India Itineraries - Recommended Travel Ideas | Traveller's Palm</title>
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection" charset="utf-8" />
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection" charset="utf-8" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/tabs.css" type="text/css" media="screen, projection" charset="utf-8" />
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/gmaps.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				Travel Themes - Recommended Travel Ideas | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_themes.tpl" -->
			</div>
			<div class="span-24 subcategory last">
				<div id="tabs">
					<ul>
						<!-- TMPL_LOOP NAME=MAINTHEMES -->
						<li<!-- TMPL_IF NAME = THEME_CURRENT --> id="<!-- TMPL_VAR NAME=THEME_CURRENT -->"<!-- /TMPL_IF -->><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes/<!-- TMPL_VAR NAME=THEME_URL -->"><!-- TMPL_VAR NAME=THEME_TITLE --></a></li>
						<!-- /TMPL_LOOP -->
					</ul>
				</div>
			</div>
			<div class="span-16">
				<div id="imgframe">
					<div id="thememapholder">
						<div id="thememap" style="width: 560px; height: 340px;"></div>
					</div>
				</div>
				<div class="prepend-4 span-8 append-4 last">
					<p id="mapnote">Select a Theme from the list on the right and click on a place marker on the map for more information</p>
				</div>
			</div>
			<div class="span-8 writeup last">
				<div id="themecitydesc"></div>
				<div id="themedesc">
					<h1><!-- TMPL_VAR NAME=THEME --></h2>
					<p><!-- TMPL_VAR NAME=THEMEINTRO --></p>
				</div>
				<div class="prepend-1 span-5 append-2 last">
					<form id="subthemelist" method="post" action="#">
						<h2>Select your <!-- TMPL_VAR NAME=THEME --> Theme</h2>
						<ul>
							<!-- TMPL_LOOP NAME=SUBTHEMES -->
							<li>
								<input type="radio" name="subtheme" id="subtheme<!-- TMPL_VAR NAME=SUBTHEME_ID -->" value="<!-- TMPL_VAR NAME=SUBTHEME_ID -->">
								<label for="subtheme<!-- TMPL_VAR NAME=SUBTHEME_ID -->"><!-- TMPL_VAR NAME=SUBTHEME_NAME --></label>
							</li>
							<!-- /TMPL_LOOP -->
						</ul>
					</form>
				</div>
			</div>
			<hr />
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

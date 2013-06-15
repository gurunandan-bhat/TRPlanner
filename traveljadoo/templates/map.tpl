<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!-- <meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> -->
		<title>Google Maps Tests</title>
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection" charset="utf-8" />
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection" charset="utf-8" />
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
		<script type="text/javascript" src="js/gmaps.js"></script>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->
			</div>
			<div class="span-24 last thememenu">
				<div class="span-4 border">
					<h3>Beaches</h3>
					<img src="images/style/red_block.gif" width="150" height="115" />
					<p>It is a long established fact that a reader will be distracted by the readable content.
					<br /><a href="#">Explore Beaches</a></p>
				</div>
				<div class="span-4 border">
					<h3>Wildlife</h3>
					<img src="images/style/red_block.gif" width="150" height="115" />
					<p>It is a long established fact that a reader will be distracted by the readable content.
					<br /><a href="#">Explore Wildlife</a></p>
				</div>
				<div class="span-4 border current">
					<h3>Landscape</h3>
					<img src="images/style/red_block.gif" width="150" height="115" />
					<p>It is a long established fact that a reader will be distracted by the readable content.
				</div>
				<div class="span-4 border">
					<h3>Adventure</h3>
					<img src="images/style/red_block.gif" width="150" height="115" />
					<p>It is a long established fact that a reader will be distracted by the readable content.
					<br /><a href="#">Explore Adventure</a></p>
				</div>
				<div class="span-4 border">
					<h3>Religion</h3>
					<img src="images/style/red_block.gif" width="150" height="115" />
					<p>It is a long established fact that a reader will be distracted by the readable content.
					<br /><a href="#">Explore Religion</a></p>
				</div>
				<div class="span-4 last">
					<h3>Monuments</h3>
					<img src="images/style/red_block.gif" width="150" height="115" />
					<p>It is a long established fact that a reader will be distracted by the readable content.
					<br /><a href="#">Explore Monuments</a></p>
				</div>
				<hr class="space" />
			</div>
			<div class="span-24 subcategory last">
				<h3>Explore Landscape</h3>
				<div class="span-16">
					<div id="map1" style="width: 620px; height: 400px; padding: 4px; border: 1px solid #eaeaea;"></div>
				</div>
				<div class="span-8 last">
					<form id="statelist" method="post" action="map.cgi">
						<fieldset>
							<legend>Select your Landscape</legend>
							<ul>
								<li>
									<input type="checkbox" name="subtheme1" id="subtheme1" value="1">
									<label for="subtheme1">Snowy Mountains</label>
								</li>
								<li>
									<input type="checkbox" name="subtheme2" id="subtheme2" value="1">
									<label for="subtheme2">Hill Stations</label>
								</li>
								<li>
									<input type="checkbox" name="subtheme3" id="subtheme3" value="1" checked="checked">
									<label for="subtheme3">Plantations</label>
								</li>
								<li>
									<input type="checkbox" name="subtheme4" id="subtheme4" value="1">
									<label for="subtheme4">Lakes Rivers and Water</label>
								</li>
								<li>
									<input type="checkbox" name="subtheme5" id="subtheme5" value="1">
									<label for="subtheme5">Deserts and Dunes</label>
								</li>
								<li>
									<input type="checkbox" name="subtheme6" id="subtheme6" value="1">
									<label for="subtheme6">Rain Forests</label>
								</li>
							</ul>
						</fieldset>
					</form>
					<h2>Plantations</h2>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the 
					industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and 
					scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap 
					into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the 
					release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
					software like Aldus PageMaker including versions of Lorem Ipsum.</p>
				</div>
			</div>
			<hr />
		</div>
	</body>
</html>

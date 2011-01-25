<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<title>Odyssey: About Us</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="plainbannermenu.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<div style="background: none;">
						<h3>The Sidebar</h3>
					</div>
				</div>
				<div class="span-12 midcol">
					<h3>Upload Image</h3>
					<form action="images.cgi" method="post" enctype="multipart/form-data">
						<p>
							<label for="imgfile">Select an Image: </label>
							<input type="file" name="imgfile" id="imgfile" /><br />
							
						</p>
						<p class="buttonContainer">
							<input type="submit" name="upload" value="Upload"/>
							<input type="hidden" name="mode" value="fiximage" />
						</p>
					</form>
				</div>
				<div class="span-8 rightcol last">
					<h3>The Sidebar</h3>
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

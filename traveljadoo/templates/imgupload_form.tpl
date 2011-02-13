<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection">
		<title>Odyssey: About Us</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
				</div>
			</div>
			<div class="span-24 last">
				<img src="images/aboutus_large.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<div style="background: none;">
						<h3>The Sidebar</h3>
					</div>
				</div>
				<div class="span-12 midcol">
					<form action="images.cgi" method="post" enctype="multipart/form-data">
					<fieldset>
						<legend>Upload Image</legend>
						<p>
							<label for="imgcat">Select an Image Category:</label><br />
							<select class="smallwidth" id="imgcat" name="imgcat" size="1">
								<option value="0">Choose a category</option>
								<!-- TMPL_LOOP NAME=IMGCATEGORIES -->
								<option value="<!-- TMPL_VAR NAME=IMGCATID -->"><!-- TMPL_VAR NAME=IMGCATNAME --></option>
								<!-- /TMPL_LOOP -->
							</select>
						</p>
						<p>
							<label for="imgtype">Select an Image Type:</label><br />
							<select class="smallwidth" id="imgtype" name="imgtype" size="1">
								<option value="0">Choose a type</option>
								<!-- TMPL_LOOP NAME=IMGTYPES -->
								<option value="<!-- TMPL_VAR NAME=IMGTYPEID -->"><!-- TMPL_VAR NAME=IMGTYPENAME --></option>
								<!-- /TMPL_LOOP -->
							</select>
						</p>
						<p>
							<label for="imgfile">Select an Image: </label>
							<input type="file" name="imgfile" id="imgfile" /><br />
							
						</p>
						<p class="buttonContainer">
							<input type="submit" name="upload" value="Upload"/>
							<input type="hidden" name="mode" value="fiximage" />
						</p>
					</fieldset>				
					<h3></h3>
					</form>
				</div>
				<div class="span-8 rightcol last">
					<h3>The Sidebar</h3>
				</div>
			</div>
		</div>
	</body>
</html>

			

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/odysseyforms.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.validate.pack.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/upload.js"></script>
		<title>The Traveller's Palm: Plan your Own Custom Trip!</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<div class="banner"><!-- TMPL_INCLUDE NAME="bannermenu.tpl" --></div>
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Privacy Statement</h3>
					<div class="box"><!-- TMPL_VAR NAME=LEFTTEXT --></div>
				</div>
				<div class="span-12 midcol">
					<h3>Your Email Address to Save and Track your Favourites</h3>
					<!-- TMPL_IF NAME=SHOWERROR -->
					<p class="error">
						We require all details below. <!-- TMPL_VAR NAME=SHOWERROR -->. Please try again.
					</p>
					<!-- /TMPL_IF -->
					<form id="register" name="registerform" method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->register.cgi">
						<fieldset id="main" style="border: none;">
							<ol>
								<li>
									<label for="email" style="font-family: Times, serif; font-size: 1.2em; font-weight: bold;">Email Address:</label>
									<input type="text" id="email" name="email" />
								</li>
							</ol>
						</fieldset>
						<fieldset class="submit">
							<input type="image" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/register-me.gif" width="203" height="25" name="submit" border="0" value="Register Me" />
						</fieldset>
					</form>
				</div>
				<div class="span-8 rightcol last">
					<h3>Why Register?</h3>
					<div class="box"><!-- TMPL_VAR NAME=RIGHTTEXT --></div>
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

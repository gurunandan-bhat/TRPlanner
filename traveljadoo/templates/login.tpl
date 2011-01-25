<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>The Travellers Palm</title>
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection" />  
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection" /><![endif]-->  
		<link rel="stylesheet" href="css/newodyssey.css" type="<!-- TMPL_VAR NAME=BASEPREFIX -->text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/hpage.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
    </head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<div class="banner">
					<!-- TMPL_INCLUDE NAME="plainbannermenu.tpl" -->
				</div>
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content" style="background: none;">
				<div class="prepend-1 span-12 append-1">
					<h3><!-- TMPL_VAR NAME=TITLE --></h3>
					<div style="font-size: 1.1em;"><!-- TMPL_VAR NAME=TEXT --></div>
				</div>
				<div class="span-8 append-2 last">
					<h3 style="margin-bottom: 0;">Sign In</h3>
					<div class="loginform" style="background: #e5e1de;">
						<form  name="loginform" method="post" action="<!-- TMPL_VAR NAME=ACTION -->">
							<fieldset class="inlineLabels" style="text-align: center">
								<!-- TMPL_IF NAME=ATTEMPTS -->
								<p class="error">
									Username or Password is Incorrect. Please enter the Username and Password assigned to you by the Administrator.
									(Attempt #: <!-- TMPL_VAR NAME=ATTEMPTS -->)
								</p>
								<!-- /TMPL_IF -->
								<p>
									<label for="authen_username" style="font-family: Times, serif; font-size: 1.2em; font-weight: bold;">Your Email Address:</label><br />
									<input class="textInput" tabindex="1" type="text" name="authen_username" size="20" value="" /><br />
									<label for="authen_password" style="font-family: Times, serif; font-size: 1.2em; font-weight: bold;">Your Password:</label><br />
									<input class="textInput" tabindex="2" type="password" name="authen_password" size="20" /><br />
									<a href="register.cgi?mode=forgotpassword" style="text-decoration: none;"><span style="color: #9f1f42; font-size: 1.2em; font-weight: bold; font-style: italic">Forgot your pasword?</span></a><br />
									<label for="authen_rememberuser"><input tabindex="3" type="checkbox" name="authen_rememberuser" value="1" /> Remember Me:</label>
								</p>
								<p class="buttonContainer">
									<input type="image" name="authen_loginbutton" value="Sign In" src="images/signin.gif" />
								</p>
								<p>
									If you have not registered, <a href="register.cgi">click here</a>.
								</p>
							</fieldset>
							<input type="hidden" name="destination" value="<!-- TMPL_VAR NAME=DESTINATION -->" />
							<input type="hidden" name="rm" value="authen_login" />
						</form>
						</div>
				</div>
			</div>
		</div>
	</body>
</html>

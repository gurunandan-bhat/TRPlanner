<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.validate.pack.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/forgotpasswd.js"></script>
		<title>The Traveller's Palm: Plan your Own Custom Trip!</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<div class="banner"><!-- TMPL_INCLUDE NAME="plainbannermenu.tpl" --></div>
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
					<h3>Request a New Password</h3>
					<!-- TMPL_IF NAME=nosuchuser -->
					<p class="error">Sorry, we have no user registered with that email address. Please provide 
					the same email address that was provided by you during registration with Traveller's Palm
					and try again.
					</p>
					<!-- TMPL_ELSE -->
					<p>
						Please enter the email address that you provided during registration and we will generate a new password
						for you and send it to your email address registered with us.
					</p>
					<!-- /TMPL_IF -->
					<div class="prepend-2 append-2 span-8 last ">
						<form id="newpasswd" name="newpasswd" method="post" action="register.cgi">
							<fieldset id="main" style="background: #fffdf6; border: none">
								<p>
									<label for="userid">Email Address:</label>
									<input type="text" id="userid" name="userid" /><br />
								</p>
								<p><input type="image" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/email-new-password.gif" width="203" height="25" border="0" name="mailpasswd" alt="Mail me my New Password" /></p>
							</fieldset>
							<input type="hidden" name="mode" value="forgotnewpasswd" />
						</form>
						<hr class="space" />
					</div>
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

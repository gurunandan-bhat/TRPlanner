<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<meta name="description" content="<!-- TMPL_VAR NAME=METADESCRIPTION -->" />
		<meta name="keywords" content="<!-- TMPL_VAR NAME=METAKEYWORDS -->" />
		<title>
			<!-- TMPL_IF NAME=PAGETITLE -->
				<!-- TMPL_VAR NAME=PAGETITLE -->
			<!-- TMPL_ELSE -->
				Legalese | Traveller's Palm - Custom Tours to India
			<!-- /TMPL_IF -->
		</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_aboutus.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/banners/banner_<!-- TMPL_VAR NAME=WEBID -->.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Membership</h3>
					<div class="box">
						<p style="text-align: center">
							<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/lato.jpg" width="58" height="78" alt="LATO Logo" /><br /><br />
							<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/taai.jpg" width="68" height="58" alt="TAAI Logo" /><br /><br />
							<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/pata.gif" width="70" height="81" alt="PATA Logo" />
						</p>
					</div>
				</div>
				<div class="span-12 midcol">
					<h3><!-- TMPL_VAR NAME=TITLE --></h3>
					<div id="contact">
					<!-- TMPL_VAR NAME=WRITEUP -->
					</div>
					<hr />
				</div>
				<div class="span-8 rightcol last">
					<img class="box" src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/odyssey_card.gif" width="246" height="150" alt="Odyssey Business Card" />
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

			
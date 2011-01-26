<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<!-- TMPL_INCLUDE NAME="googletracker.tpl" -->
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/jquery-ui-1.7.1.custom.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-ui-1.7.2.custom.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/intro.js"></script>
		<title>Odyssey: About Us</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu.tpl" -->					
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/banners/banner_smartroutefinder.jpg" width="950" height="150" alt="Collage"/>
			</div>
			<hr class="space" />
			<div class="content">
				<div class="span-4 leftcol">
					&nbsp;
				</div>
				<div class="span-12 midcol">
					<h3>Our Smart Route Finder</h3>
					<form method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->routefinder.cgi">
						<fieldset>
							<legend>Enter your Travel Details</legend>
							<table cellspacing="0" cellpadding="0">
								<tr>
									<td width="50"></td>
									<td width="150"></td>
									<td width="50"></td>
									<td width="25">HH</td>
									<td width="25">MM</td>
									<td width="110"></td>
								</tr>
								<tr>
									<td><label for="arrdate">Date: </label></td>
									<td><input type="text" id="arrdate" name ="arrdate" value="<!-- TMPL_VAR NAME=TRDATE -->" style="width: 150px;" /></td>
									<td><label for="trhh">Time: </label></td>
									<td><input type="text" id="trhh" name="trhh" value="<!-- TMPL_VAR NAME=TRHH -->" style="width: 25px;" /></td>
									<td><input type="text" id="trmm" name="trmm" value="<!-- TMPL_VAR NAME=TRMM -->" style="width: 25px;" /></td>
									<td>Default: 8 am.</td>
								</tr>
								<tr>
									<td><label for="src">From: </label></td>
									<td align="left">
										<select id="src" name="src" size="1" style="width: 150px;">
											<option value="0">Starting City</option>
										<!-- TMPL_LOOP NAME=FROMCITIES -->
											<option value="<!-- TMPL_VAR NAME=CITYID -->"<!-- TMPL_IF NAME=SELECTED --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=CITY --></option>
										<!-- /TMPL_LOOP -->
										</select>
									</td>
									<td><label for="dest">To: </label></td>
									<td colspan="3" align="left">
										<select id="dest" name="dest" size="1" style="width: 160px;">
											<option value="0">Destination City</option>
										<!-- TMPL_LOOP NAME=TOCITIES -->
											<option value="<!-- TMPL_VAR NAME=CITYID -->"<!-- TMPL_IF NAME=SELECTED --> selected="selected"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=CITY --></option>
										<!-- /TMPL_LOOP -->
										</select>
									</td>
								</tr>
							</table>
							<input type="submit" name="submit" value="Search" />
						</fieldset>
					</form>
					<h3>Results</h3>
					<!-- TMPL_VAR NAME=OPTIONS -->
				</div>
				<div class="span-8 rightcol last">
					<h3><!-- TMPL_VAR NAME=TITLE --></h3>
					<div class="box"><!-- TMPL_VAR NAME=TEXT --></div>
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

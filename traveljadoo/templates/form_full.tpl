<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/odysseyforms.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/jquery-ui-1.7.1.custom.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-ui-1.7.1.custom.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/intro.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.validate.pack.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/mustache.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/form-validate.js"></script>
		<title>The Traveller's Palm: Plan your Own Custom Trip!</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_planatrip.tpl" -->
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Sidebar</h3>
				</div>
				<div class="span-12 midcol">
					<h3>Tour Booking Form</h3>
					<form id="planatrip" method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->togateway" maxpax="<!-- TMPL_VAR NAME=pax -->">
						<!--  TMPL_IF NAME=some_errors  -->
						<p class="error">There were some errors</p>
						<!-- /TMPL_IF -->
						<fieldset id="main">
							<legend>Details about your Party</legend>
							<ol>
								<li>
									<label for="name1">Lead Name (i.e your full name as on your passport):<!-- TMPL_VAR NAME=err_name1 --></label>
									<input type="text" id="name1" name="name1" />
								</li>
 								<li>
									<label for="nationality1">Nationality:<!-- TMPL_VAR NAME=err_nationality1 --></label>
									<input type="text" id="nationality1" name="nationality1" />
								</li>
								<li>
									<label for="passport1">Passport No:<!-- TMPL_VAR NAME=err_passport1 --></label>
									<input type="text" id="passport1" name="passport1" />
								</li>
								<li>
									<label for="issuedon1">Passport Issue Date:<!-- TMPL_VAR NAME=err_issuedon1 --></label>
									<input type="text" id="issuedon1" name="issuedon1" />
								</li>
								<li>
									<label for="expireson1">Passport Expiry Date:<!-- TMPL_VAR NAME=err_expireson1 --></label>
									<input type="text" id="expireson1" name="expireson1" />
								</li>
								<hr />
							</ol>
							<!--  TMPL_LOOP NAME=restpax -->
								<p class="paxnumber">Details of Traveller <!-- TMPL_VAR NAME=paxorder --></p>
								<ol>
									<li>
										<label for="name1">Full name (as on passport): <!-- TMPL_VAR NAME=errorname --></label>
										<input type="text" id="name<!-- TMPL_VAR NAME=paxorder -->" name="name<!-- TMPL_VAR NAME=paxorder -->" />
									</li>
									<li>
										<label for="nationality<!-- TMPL_VAR NAME=paxorder -->">Nationality: <!-- TMPL_VAR NAME=errornationality --></label>
										<input type="text" id="nationality<!-- TMPL_VAR NAME=paxorder -->" name="nationality<!-- TMPL_VAR NAME=paxorder -->" />
									</li>
									<li>
										<label for="passport<!-- TMPL_VAR NAME=paxorder -->">Passport No: <!-- TMPL_VAR NAME=errorpassport --></label>
										<input type="text" id="passport<!-- TMPL_VAR NAME=paxorder -->" name="passport<!-- TMPL_VAR NAME=paxorder -->" />
									</li>
									<li>
										<label for="issuedon<!-- TMPL_VAR NAME=paxorder -->">Passport Issue Date: <!-- TMPL_VAR NAME=errorissuedon --></label>
										<input type="text" id="issuedon<!-- TMPL_VAR NAME=paxorder -->" name="issuedon<!-- TMPL_VAR NAME=paxorder -->" />
									</li>
									<li>
										<label for="expireson<!-- TMPL_VAR NAME=paxorder -->">Passport Expiry Date: <!-- TMPL_VAR NAME=errordexpireson --></label>
										<input type="text" id="expireson<!-- TMPL_VAR NAME=paxorder -->" name="expireson<!-- TMPL_VAR NAME=paxorder -->" />
									</li>
									<hr />
								</ol>
							<!-- /TMPL_LOOP -->
						</fieldset>
						<fieldset id="corr">
							<legend>Who should we correspond with</legend>
							<ol>
								<li>
									<label for="corrname">Name (as on passport): <!-- TMPL_VAR NAME=err_corrname --></label>
									<input type="text" id="corrname" name="corrname" />
								</li>
								<li>
									<label for="corraddress1">Address (Line 1): <!-- TMPL_VAR NAME=err_corraddress1 --></label>
									<input type="text" id="corraddress1" name="corraddress1" />
								</li>
								<li>
									<label for="corraddress2">Address (Line 2):</label>
									<input type="text" id="corraddress2" name="corraddress2" />
								</li>
								<li>
									<label for="corrcity">City: <!-- TMPL_VAR NAME=err_corrcity --></label>
									<input type="text" id="corrcity" name="corrcity" />
								</li>
								<li>
									<label for="corrzip">Zip/Pin: <!-- TMPL_VAR NAME=err_corrzip --></label>
									<input type="text" id="corrzip" name="corrzip" />
								</li>
								<li>
									<label for="corrstate">State: <!-- TMPL_VAR NAME=err_corrstate --></label>
									<input type="text" id="corrstate" name="corrstate" />
								</li>
								<li>
									<label for="corrcountry">Country: <!-- TMPL_VAR NAME=err_corrcountry --></label>
									<input type="text" id="corrcountry" name="corrcountry" />
								</li>
								<li>
									<label for="corremail">Email: <!-- TMPL_VAR NAME=err_corremail --></label>
									<input type="text" id="corremail" name="corremail" />
								</li>
								<li>
									<label for="travelemail">Email while travelling: <!-- TMPL_VAR NAME=err_travelemail --></label>
									<input type="text" id="travelemail" name="travelemail" />
								</li>
								<li>
									<label for="telehome">Telephone (Home): <!-- TMPL_VAR NAME=err_telehome --></label>
									<input type="text" id="telehome" name="telehome" />
								</li>
								<li>
									<label for="telework">Telephone (Work)</label>
									<input type="text" id="telework" name="telework" />
								</li>
							</ol>
						</fieldset>
						<fieldset id="corr">
							<legend>Emergency Contact Details: Important</legend>
							<ol>
								<li>
									<label for="ename">Name: <!-- TMPL_VAR NAME=err_ename --></label>
									<input type="text" id="ename" name="ename" />
								</li>
								<li>
									<label for="eemail">Email: <!-- TMPL_VAR NAME=err_eemail --></label>
									<input type="text" id="eemail" name="eemail" />
								</li>
								<li>
									<label for="etelehome">Telephone (Home): <!-- TMPL_VAR NAME=err_etelehome --></label>
									<input type="text" id="etelehome" name="etelehome" />
								</li>
								<li>
									<label for="etelecell">Telephone (Cellphone)</label>
									<input type="text" id="etelecell" name="etelecell" />
								</li>
							</ol>
						</fieldset>
						<p>
							<input type="checkbox" id="haveread" name="haveread" value="1"> 
							<label for="haveread" style="font-size: 11px; font-weight: normal;">
								I have read the <a target="_blank" href="<!-- TMPL_VAR NAME=BASEPREFIX -->booking-conditions">conditions of booking</a> and accept them on behalf of all members of my party by 
								whom I am duly authorised to make this agreement. <!-- TMPL_VAR NAME=err_haveread -->
							</label>
						</p>
						<p>
							<input type="checkbox" id="goodhealth" name="goodhealth" value="1">
							<label for="goodhealth"  style="font-size: 11px; font-weight: normal;">
								 I certify that my / our health and level of fitness is sufficient to complete the itinerary.
								 <!-- TMPL_VAR NAME=err_goodhealth -->
							</label>
						</p>
						<fieldset class="submit">
							<input type="submit" name="submit" value="Book my Tour" />
						</fieldset>
						<input type="hidden" name="qid" value="<!-- TMPL_VAR NAME=qid -->" />
						<input type="hidden" name="uuid" value="<!-- TMPL_VAR NAME=uuid -->" />
						<input type="hidden" name="digest" value="<!-- TMPL_VAR NAME=digest -->" />
					</form>
				</div>
				<div class="span-8 rightcol last">
					<h3>Sidebar</h3>
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

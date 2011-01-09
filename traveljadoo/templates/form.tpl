<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/odysseyforms.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="css/jquery-ui-1.7.1.custom.css" type="text/css" media="screen, projection">
		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui-1.7.1.custom.min.js"></script>
		<script type="text/javascript" src="js/intro.js"></script>
		<script type="text/javascript" src="js/blk.js"></script>
		<script type="text/javascript" src="js/jquery.validate.pack.js"></script>
		<script type="text/javascript" src="js/form-validate.js"></script>
		<title>The Traveller's Palm: Plan your Own Custom Trip!</title>
	</head>
	<body>
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_planatrip.tpl" -->
			</div>
			<div class="span-24 last">
				<img src="images/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Sidebar</h3>
				</div>
				<div class="span-12 midcol">
					<h3>Tour Booking Form</h3>
					<form id="planatrip" method="post" action="index.cgi">
						<input type="hidden" name="mode" value="start" />
						<fieldset id="main">
							<legend>Details about your Party</legend>
							<ol>
								<li>
									<label for="pax">Number of Travellers: </label>
									<select class="smallwidth" id="pax" name="pax" size="1">
										<option value="1">1</option>
										<option value="2" selected="selected">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										<option value="6">6</option>
										<option value="7">7</option>
										<option value="8">8</option>
										<option value="9">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
									</select>
								</li>
								<li>
									<label for="leadname">Lead Name (i.e your full name as on your passport):</label>
									<input type="text" id="leadname" name="leadname" />
								</li>
								<li>
									<label for="nationality">Nationality:</label>
									<input type="text" id="nationality" name="nationality" />
								</li>
								<li>
									<label for="passport">Passport No:</label>
									<input type="text" id="passport" name="passport" />
								</li>
								<li>
									<label for="issuedon">Passport Issue Date:</label>
									<input type="text" id="issuedon" name="issuedon" />
								</li>
								<li>
									<label for="expireson">Passport Expiry Date:</label>
									<input type="text" id="expireson" name="expires" />
								</li>
								<hr />
								<a href="#">Click here to add another member to your party</a>
							</ol>
						</fieldset>
						<fieldset id="arrdep">
							<legend>Your Arrival and Departure Details</legend>
							<h2>Arrival Details</h2>
							<ol>
								<li>
									<Label for="arrdate">Arrival Date: </Label>
									<input id="arrdate" name="arrdate" type="text" />
								</li>
								<li>
									<Label for="arrtimehh">Arrival Time HH: MM</Label>
									<select class="smallwidth" id="arrtimehh" name="arrtimehh" size="1">
										<option value="">HH</option>
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09" selected="selected">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
									<select class="smallwidth" id="arrtimemm" name="arrtimemm" size="1">
										<option value="">MM</option>
										<option value="00" selected="selected">00</option>
										<option value="15">15</option>
										<option value="30">30</option>
										<option value="45">45</option>
									</select>
								</li>
								<li>
									<label for="inflight">Flight No: </label>
									<input type="text" id="inflight" name="inflight">
								</li>
								<li>
									<label for="inflightcity">Arriving from: </label>
									<input type="text" id="inflightcity" name="inflightcity">
								</li>
								<li>
									<label for="arrplace">Arriving In (City): </label>
									<select id="arrplace" name="arrplace" size="1">
										<!-- TMPL_VAR NAME=ARRCITYOPTIONS -->
									</select>
								</li>
							</ol>
							<hr />
							<h2>Departure</h2>
							<ol>
								<li>
									<Label for="depdate">Departure Date: </Label>
									<input id="depdate" name="depdate" type="text" /><br />
								</li>
								<li>
									<Label for="deptimehh">Departure Time HH: MM</Label>
									<select class="smallwidth" id="deptimehh" name="deptimehh" size="1">
										<option value="">HH</option>
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09" selected="selected">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
									<select class="smallwidth" id="deptimemm" name="deptimemm" size="1">
										<option value="">MM</option>
										<option value="00" selected="selected">00</option>
										<option value="15">15</option>
										<option value="30">30</option>
										<option value="45">45</option>
									</select>
								</li>
								<li>
									<label for="outflight">Flight No: </label>
									<input type="text" id="outflight" name="outflight">
								</li>
								<li>
									<label for="destination">Destination: </label>
									<input type="text" id="destination" name="destination">
								</li>
								<li>
									<label for="depplace">I am departing from: </label>
									<select id="depplace" name="depplace" size="1">
										<!-- TMPL_VAR NAME=ARRCITYOPTIONS -->
									</select>
								</li>
							</ol>
						</fieldset>
						<fieldset id="corr">
							<legend>Who should we correspond with</legend>
							<ol>
								<li>
									<label for="corrname">Name (as on passport):</label>
									<input type="text" id="corrname" name="corrname" />
								</li>
								<li>
									<label for="nationality">Address:</label>
									<textarea rows="6" style="height: 6em;"></textarea>
								</li>
								<li>
									<label for="email">Email</label>
									<input type="text" id="email" name="email" />
								</li>
								<li>
									<label for="telehome">Telephone (Home)</label>
									<input type="text" id="telehome" name="telehome" />
								</li>
								<li>
									<label for="telehome">Telephone (Work)</label>
									<input type="text" id="telework" name="telework" />
								</li>
							</ol>
						</fieldset>
						<fieldset id="corr">
							<legend>Emergency Contact Details: Important</legend>
							<ol>
								<li>
									<label for="corrname">Name:</label>
									<input type="text" id="corrname" name="corrname" />
								</li>
								<li>
									<label for="email">Email</label>
									<input type="text" id="email" name="email" />
								</li>
								<li>
									<label for="telehome">Telephone (Home)</label>
									<input type="text" id="telehome" name="telehome" />
								</li>
								<li>
									<label for="telehome">Telephone (Work)</label>
									<input type="text" id="telework" name="telework" />
								</li>
							</ol>
						</fieldset>
						<input type="checkbox" id="agree"><label for="agree">I agree with .....</label>
						<fieldset class="submit">
							<input type="submit" name="submit" value="Book my Tour" />
						</fieldset>
						<input type="hidden" name="mode" value="start" />
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

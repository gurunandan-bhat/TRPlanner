<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<title>Itinerary for <!-- TMPL_VAR NAME=TRAVELLER --></title>
	</head>
	<body>
		<p>
			<b>Quotation Request Received From: <!-- TMPL_VAR NAME=PAXNAME --></b><br />
			<b>Email Address of Lead Traveller: <!-- TMPL_VAR NAME=PAXEMAIL --></b><br />
			<b>Ouotation ID of Custom Tour: <!-- TMPL_VAR NAME=QUOTEID --></b><br />
		</p>
		<p>
			<b>Dear <!-- TMPL_VAR NAME=PAXNAME -->,</b>
		</p>
		<p>
			Thank you for making an enquiry through <a href="www.travelers-palm.com">Traveller's Palm</a>. 
			We value your business and look forward to assisting you.
		</p>
		<p>
			Please find below the itinerary request you have just made with us. We will now prepare a quotation 
			for you and get back to you with details within the next two working days.
		</p>
		<p>
			Best regards,<br />
			Phil Rolph <br />
			Traveller's Palm
		</p>
		<p>&nbsp;</p>
		<p>
			<b>Day-to-Day Itinerary for: <!-- TMPL_VAR NAME=PAXNAME --></b>
		</p>
		<!-- TMPL_LOOP NAME=SUMMARY -->
		<p>
			<b>Day <!-- TMPL_VAR NAME=DAYNUM --> (<!-- TMPL_VAR NAME=DATE -->), <!-- TMPL_VAR NAME=CITY --></b><br />
			<!-- TMPL_VAR NAME=DETAIL -->
		</p>
		<!-- /TMPL_LOOP -->
		<p>
			<b>Special Request:</b><br />
			<!-- TMPL_VAR NAME=SQREQUEST -->
		</p>
	</body>
</html>

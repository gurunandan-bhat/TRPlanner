<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<title>Tours and Modules for <!-- TMPL_VAR NAME=LEADNAME --></title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<p>
			<b>Quotation Request Received From: <!-- TMPL_VAR NAME=LEADNAME --></b><br />
			<b>Email Address of Lead Traveller: <!-- TMPL_VAR NAME=LEADEMAIL --></b><br />
		</p>
		<p>
			<b>Dear <!-- TMPL_VAR NAME=LEADNAME -->,</b>
		</p>
		<p>
			Thank you for making an enquiry through <a href="www.travellers-palm.com">Traveller's Palm</a>.
			We value your business and look forward to assisting you.
		</p>
		<p>
			Please find below the tours/modules you have inquired with us. We will now prepare a quotation 
			for you and get back to you with details within the next two working days.
		</p>
		<p>
			Best regards,<br />
			Phil Rolph <br />
			Traveller’s Palm
		</p>
		<p>&nbsp;</p>
		<p>
			<b>Trips for: <!-- TMPL_VAR NAME=LEADNAME --></b>
		</p>
		<!-- TMPL_LOOP NAME=ITINS -->
		<p>
			<b><!-- TMPL_VAR NAME=ITINNAME --></b><br />
			<!-- TMPL_VAR NAME=ITINDESC -->
		</p>
		<!-- /TMPL_LOOP -->
		<p>
			<b>Special Request:</b><br />
			<!-- TMPL_VAR NAME=REQUEST -->
		</p>
	</body>
</html>

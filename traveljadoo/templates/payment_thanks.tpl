<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/newodyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/odysseyforms.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/blk.js"></script>
		<title>The Traveller's Palm: Plan your Own Custom Trip!</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<!-- TMPL_INCLUDE NAME="bannermenu_planatrip.tpl" -->
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Sidebar</h3>
				</div>
				<div class="span-12 midcol">
					<h3>Thank You</h3>
					<p>
						<b>Dear <!-- TMPL_VAR NAME=lead -->,</b>
					</p>
					<p>
						Thank you for making a payment of <!-- TMPL_VAR NAME=currency --> <!-- TMPL_VAR NAME=amt -->. We look forward to assisting you
						during your tour. Please save the details of your payment for your reference. We have also sent you an email with an acknowledgement
						of your payment.
					</p>
					<p>
						If you wish to print a receipt for your payment, please click here. Your payment details are as follows:
					</p>
					<table>
						<tr><th>Item</th><th style="text-align: right;">Reference</th></tr>
						<tr>
							<td>Quotation No:</td>
							<td style="text-align: right;"><!-- TMPL_VAR NAME=qid --></td>
						</tr>
						<tr>
							<td>Transaction No:</td>
							<td style="text-align: right;"><!-- TMPL_VAR NAME=tranid --></td>
						</tr>
						<tr>
							<td>Bank Payment Reference No:</td>
							<td style="text-align: right;"><!-- TMPL_VAR NAME=refid --></td>
						</tr>
						<tr>
							<td>Payment Date:</td>
							<td style="text-align: right;"><!-- TMPL_VAR NAME=trandate --></td>
						</tr>
						<tr>
							<td>Amount Paid</td>
							<td style="text-align: right;"><!-- TMPL_VAR NAME=currency --> <!-- TMPL_VAR NAME=amt --></td>
						</tr>
					</table>
					<p>
						Best regards,<br />
						<strong>Phil Rolph</strong> <br />
						<strong>Traveller's Palm</strong>
					</p>
				</div>
				<div class="span-8 rightcol last">
					<h3>View Your Itinerary</h3>
					<p class="box"><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->userfiles/<!-- TMPL_VAR NAME=qid -->.pdf" target="_blank">Click here</a> to view your itinerary for this tour.</p>
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

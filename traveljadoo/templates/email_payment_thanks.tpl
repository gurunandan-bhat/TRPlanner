<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<title>Tours and Modules for <!-- TMPL_VAR NAME=lead --></title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<table border="0" cellspacing="0" cellpadding="0" width="500">
			<tr><td colspan="2" height="110" width="500"><img src="cid:reciept_banner" width="500" height="110" /></td></tr>
			<tr>
				<td width="40%"><b>Lead Name: </b></td>
				<td width="60%"><b><!-- TMPL_VAR NAME=lead --></b></td>
			</tr>
			<tr>
				<td width="40%"><b>Email Address: </b></td>
				<td width="60%"><b><!-- TMPL_VAR NAME=email --></b></td>
			</tr>
			<tr>
				<td width="40%"><b>Quotation Number: </b></td>
				<td width="60%"><b><!-- TMPL_VAR NAME=qid --></b></td>
			</tr>
			<tr>
				<td colspan="2">
					<p>
						<b>Dear <!-- TMPL_VAR NAME=lead -->,</b>
					</p>
					<p>
						Thank you for making a payment to <b>Traveller's Palm</b>.<br /> 
						The details of your payment are as follows:
					</p>

				</td>
			</tr>
			<tr style="background: #31316a; color: #fff; font-weight: bold;">
				<th width="40%">Item</th>
				<th width="60%" style="text-align: right;">Reference</th>
			</tr>
			<tr>
				<td width="40%">Quotation No:</td>
				<td width="60%" style="text-align: right;"><!-- TMPL_VAR NAME=qid --></td>
			</tr>
			<tr>
				<td width="40%">Transaction No:</td>
				<td width="60%" style="text-align: right;"><!-- TMPL_VAR NAME=tranid --></td>
			</tr>
			<tr>
				<td width="40%">Bank Payment Reference No:</td>
				<td width="60%" style="text-align: right;"><!-- TMPL_VAR NAME=ref --></td>
			</tr>
			<tr>
				<td width="40%">Bank Payment Id:</td>
				<td width="60%" style="text-align: right;"><!-- TMPL_VAR NAME=paymentid --></td>
			</tr>
			<tr>
				<td width="40%">Payment Date:</td>
				<td width="60%" style="text-align: right;"><!-- TMPL_VAR NAME=trandate --></td>
			</tr>
			<tr style="background: #31316a; color: #fff; font-weight: bold;">
				<th width="40%">Amount Paid</th>
				<th width="60%" style="text-align: right;"><!-- TMPL_VAR NAME=currency --> <!-- TMPL_VAR NAME=amt --></th>
			</tr>
			<tr>
				<td colspan="2">
					<p>
						Please find attached your Tour Itinerary.<br />
						We look forward to assisting you during your tour.
					<p>
						Best regards,<br />
						<b>Traveller's Palm</b>
					</p>
					<p style="color: red;">
						Please Note:
					</p>
					<ol style="color: red;">
						<li style="color: red;">This is system-generated invoice. There is no need for physical signature</li>
						<li style="color: red;">Please do not reply to this email. It has been sent by an automated booking system from an address that is not monitored.</li>
					</ol>  
				</td>
			</tr>
		</table>
	</body>
</html>

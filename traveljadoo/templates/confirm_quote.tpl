<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/print.css" type="text/css" media="print"> 
		<!--[if lt IE 8]><link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ie.css" type="text/css" media="screen, projection"><![endif]-->
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/ch_odyssey.css" type="text/css" media="screen, projection"> 
		<link rel="stylesheet" href="<!-- TMPL_VAR NAME=BASEPREFIX -->css/odysseyforms.css" type="text/css" media="screen, projection"> 
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/jquery.validate.pack.js"></script>
		<script type="text/javascript" src="<!-- TMPL_VAR NAME=BASEPREFIX -->js/upload.js"></script>
		<title>The Traveller's Palm: Payment Details!</title>
	</head>
	<body baseprefix="<!-- TMPL_VAR NAME=BASEPREFIX -->">
		<div class="container">
			<div class="span-24 last">
				<div class="banner"><!-- TMPL_INCLUDE NAME="bannermenu.tpl" --></div>
			</div>
			<div class="span-24 last">
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Upload Instructions</h3>
				</div>
				<div class="span-12 midcol">
					<h3>Quotation Details</h3>
					<!-- TMPL_IF NAME=SHOWERROR -->
					<p class="error">
						We require all details below. <!-- TMPL_VAR NAME=SHOWERROR -->. Please try again.
					</p>
					<!-- /TMPL_IF -->
					<table>
						<tr class="odd"><th style="text-align: right;">Party:</th><th><strong><!-- TMPL_VAR NAME=lead --></strong></th></tr>
						<tr><td style="text-align: right;">Ouotation Id:</td><td><strong><!-- TMPL_VAR NAME=qid --></strong></td></tr>
						<tr class="odd"><td style="text-align: right;">Email:</td><td><strong><!-- TMPL_VAR NAME=email --></strong></td></tr>
						<tr><td style="text-align: right;">Pax:</td><td><strong><!-- TMPL_VAR NAME=pax --></strong></td></tr>
						<tr><td style="text-align: right;">Currency:</td><td><strong><!-- TMPL_VAR NAME=currency --></strong></td></tr>
						<tr class="odd"><td style="text-align: right;">Rate per Person:</td><td><strong><!-- TMPL_VAR NAME=ratepp --></strong></td></tr>
						<tr><td style="text-align: right;">Tax Percentage:</td><td><strong><!-- TMPL_VAR NAME=taxpc --></strong></td></tr>
						<tr class="odd"><td style="text-align: right;">Total Tax:</td><td><strong><!-- TMPL_VAR NAME=tax --></strong></td></tr>
						<tr><td style="text-align: right;">Total Amount:</td><td><strong><!-- TMPL_VAR NAME=amt --></strong></td></tr>
						<tr class="odd"><td style="text-align: right;">Advance Amount:</td><td><strong><!-- TMPL_VAR NAME=advamt --></strong></td></tr>
						<tr class="odd"><td style="text-align: right;">Payable Before:</td><td><strong><!-- TMPL_VAR NAME=advdate --></strong></td></tr>
						<tr><td style="text-align: right;">Balance Amount:</td><td><strong><!-- TMPL_VAR NAME=balamt --></strong></td></tr>
						<tr class="odd"><td style="text-align: right;">Payable Before:</td><td><strong><!-- TMPL_VAR NAME=baldate --></strong></td></tr>
					</table>
					<form id="savequote" name="savequote" method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->save_quote">
						<input type="hidden" name="qid" value="<!-- TMPL_VAR NAME=qid -->" />
						<input type="hidden" name="lead" value="<!-- TMPL_VAR NAME=lead -->" />
						<input type="hidden" name="pax" value="<!-- TMPL_VAR NAME=pax -->" />
						<input type="hidden" name="email" value="<!-- TMPL_VAR NAME=email -->" />
						<input type="hidden" name="ratepp" value="<!-- TMPL_VAR NAME=ratepp -->" />
						<input type="hidden" name="taxpc" value="<!-- TMPL_VAR NAME=taxpc -->" />
						<input type="hidden" name="tax" value="<!-- TMPL_VAR NAME=tax -->" />
						<input type="hidden" name="amt" value="<!-- TMPL_VAR NAME=amt -->" />
						<input type="hidden" name="advamt" value="<!-- TMPL_VAR NAME=advamt -->" />
						<input type="hidden" name="advdate" value="<!-- TMPL_VAR NAME=advdate -->" />
						<input type="hidden" name="balamt" value="<!-- TMPL_VAR NAME=balamt -->" />
						<input type="hidden" name="baldate" value="<!-- TMPL_VAR NAME=baldate -->" />
						<input type="hidden" name="curr" value="<!-- TMPL_VAR NAME=curr -->" />
						<input type="hidden" name="currency" value="<!-- TMPL_VAR NAME=currency -->" />
						<p style="text-align: center;">
							<input type="submit" name="submit" border="0" value="Confirm" />
						</p>
					</form>
					<hr class="space" />
				</div>
				<div class="span-8 rightcol last">
					<h3>Recent Quotations</h3>
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

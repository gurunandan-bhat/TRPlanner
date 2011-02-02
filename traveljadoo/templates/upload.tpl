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
					<h3>Upload Quotation Details</h3>
					<!-- TMPL_IF NAME=some_errors -->
					<p class="error">
						There were problems in submitting this form. The errors are listed below each lable. 
						Please fix the problem and try again.
					</p>
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=mismatch_errors -->
					<p class="error">
						The file names must be quotation ids (string of numbers only) and must be the same
						for the PDF and the TXT file. Please upload correctly matched files.
					</p>
					<!-- /TMPL_IF -->
					<!-- TMPL_IF NAME=filecp_errors -->
					<p class="error">
						There was an error copying files: <!-- TMPL_VAR NAME=filecp_errors --> 
					</p>
					<!-- /TMPL_IF -->
					<form id="uploadform" name="uploadform" enctype="multipart/form-data" method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->upload_quote">
						<fieldset>
							<legend>Upload the PDF and the Quotation File</legend>
							<p>
								<label for="pdffile">
									PDF File: <!-- TMPL_VAR NAME=err_pdffile -->
								</label>
								<input type="file" id="pdffile" name="pdffile"  value="<!-- TMPL_VAR NAME=pdffile -->" />
							</p>
							<hr class="space" />
							<p>
								<label for="txtfile">
									Quotation Text File: <!-- TMPL_VAR NAME=err_txtfile -->
								</label>
								<input type="file" id="txtfile" name="txtfile" value="<!-- TMPL_VAR NAME=txtfile -->" />
							</p>
							<p style="text-align: center;">
								<input type="submit" name="submit" border="0" value="Upload" />
							</p>
						</fieldset>
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

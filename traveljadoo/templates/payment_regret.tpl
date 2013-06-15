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
				<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/style/planatrip_large.jpg" width="950" height="150" />
			</div>
			<div class="content">
				<div class="span-4 leftcol">
					<h3>Sidebar</h3>
				</div>
				<div class="span-12 midcol">
					<h3>Sorry!</h3>
					<p>
						Unfortunately, your Payment has been declined.
					</p>
					<p>
						To protect your security and privacy, your bank cannot provide us with information about why your payment was declined. 
						It may be that you have insufficient funds in your account, that your card has been blocked because of unusual or suspicious 
						activity, or that the details you have provided do not match those held by your issuing bank.
					</p>
					<p>
						If your card is being declined, the best course of action is to call your credit card company using the number on the back 
						of the card to inquire about the problem. Typically, your credit card vendor will be able to sort out the problem and ensure 
						that your next attempt to make an online payment is successful.
					</p>
					<p>
						If you want to try again with a different card or confirm your details are correct by retrying your current card, please do the following:
					</p>
					<ul>
						<li>Go back to the e-mail we sent you and click again on the link we provided to return to our Booking Form.</li>
						<li>Enter the Details about your Party again</li>
						<li>Retry your current card or try a different card</li>
					</ul>
					<p>
						Just one last thing: your credit card could be genuine, have more than sufficient funds available to pay for your purchase, 
						but for some unknown reason, your transaction might still not be authorized and the payment not accepted. In this case, please 
						contact us so that we can give you instructions for making a telegraphic bank transfer to our account.
					</p>
					<p>
						Best regards,<br />
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

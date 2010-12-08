<?php

// IMPORTANT NOTE - Merchant should ensure that he is not using demo pages in production, 
// also merchant should ensure that request from merchant page  to plugin goes in secure manner

// Expects the following
// TrackId
// Currency Code
// Amount
// UDF1-5
//
// Return Codes
// -1 Bad Request
// 0 URL not returned
// URL Success - Now redirect

// TODO Add some signature to identify source

	if ($_SERVER['REQUEST_METHOD'] == 'GET') {

		echo -1;
		exit;
	}
	
	$trackid = isset($_POST['trackid']) ?  $_POST['trackid'] : 0;
	$currency = isset($_POST['currency']) ?  $_POST['currency'] : 0;
	$amount = isset($_POST['amount']) ?  $_POST['amount'] : 0;
	$udf1 = isset($_POST['udf1']) ?  $_POST['udf1'] : 0;

	if (!($trackid && $currency && $amount && $udf1)) {
		
		echo  -1;
		exit;
	}
	
	
	
	require_once('java/Java.inc');

	$pipe = new Java('com.aciworldwide.commerce.gateway.plugins.e24PaymentPipe');
	
	$pipe->setLanguage("USA");
	$pipe->setAction("1");
	$pipe->setResponseURL("http://www.travellers-palm.com/success");
	$pipe->setErrorURL("http://www.travellers-palm.com/failure");
	$pipe->setResourcePath("/home/tpcom/traveljadoo/conf/");
	$pipe->setAlias("90001343");
	
	$pipe->setCurrency($currency);
	$pipe->setAmt($amount);
	$pipe->setTrackId($trackid); 
	$pipe->setUdf1($udf1);
	
	$status = $pipe->performPaymentInitialization();
	
	if ($status == -1) {

		echo 0;
		exit;
	}
	elseif ($status == 0) {

		$payID = $pipe->getPaymentId();
		$payURL = $pipe->getPaymentPage();
		
		header('Content-type: text/plain');
		echo "$payURL?PaymentID=$payID";

		exit;
	}
	elseif {

		echo -1,
		exit;
	}
	

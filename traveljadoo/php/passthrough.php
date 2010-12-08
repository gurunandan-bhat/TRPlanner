<?php

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
	
	$trackid  = isset($_POST['trackid']) ?  $_POST['trackid'] : 0;
	$currency = isset($_POST['currency']) ?  $_POST['currency'] : 0;
	$amount   = isset($_POST['amount']) ?  $_POST['amount'] : 0;
	$alias    = isset($_POST['alias']) ? $_POST['alias'] : 0;
	$respurl  = isset($_POST['respurl']) ? $_POST['respurl'] : 0;
	$errurl   = isset($_POST['errurl']) ? $_POST['errurl'] : 0;
	$rsrcpath = isset($_POST['rsrcpath']) ? $_POST['rsrcpath'] : 0;
	$udf1     = isset($_POST['udf1']) ?  $_POST['udf1'] : 0;
	$udf2     = isset($_POST['udf2']) ?  $_POST['udf2'] : 0;
	
	if (!($trackid && $currency && $amount && $udf1)) {
		
		echo  -1;
		exit;
	}
	
	require_once('java/Java.inc');
	$pipe = new Java('com.aciworldwide.commerce.gateway.plugins.e24PaymentPipe');
	
	$pipe->setLanguage("USA");
	$pipe->setAction("1");

	$pipe->setResponseURL($respurl);
	$pipe->setErrorURL($errurl);
	$pipe->setResourcePath($rsrcpath);
	$pipe->setAlias($alias);
	$pipe->setCurrency($currency);
	$pipe->setAmt($amount);
	$pipe->setTrackId($trackid); 
	$pipe->setUdf1($udf1);
	$pipe->setUdf2($udf2);
	
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
	

<?php

// Define constants rather than waste time looking up in currency database 
// since we have only 2 currencies
	
	$params = array (
		'INR' => array (
			'hdfccode' => '356',
			'terminalid' => '70802123',
			'merchantid' => '20107',
		),
		'USD' => array (
			'hdfccode' => '840',
			'terminalid' => '79020147',
			'merchantid' => '22159',
		)
	);
			
// TODO Validate each value using the "filter_var" function after testing

	$currency = $_POST['currency'];
	$amount = $_POST['amount'];
	$trackid = $_POST['trackid'];
	$udf1 = $_POST['udf1'];
	$udf2 = $_POST['udf2'];
	$udf3 = $_POST['udf3'];
	$udf4 = $_POST['udf4'];
	$udf5 = $_POST['udf5'];
	
// Insert in Transactions table in Database	
	
	$dbhost = '64.34.178.175:2301';
	$dbname = 'casm_2012';
	$dbuser = 'casm_2012';
	$dbpswd = 'root123';

	try {
		$dbh = new PDO("dblib:host=$dbhost;dbname=$dbname", $dbuser, $dbpswd);

		$count = $dbh->prepare("
			INSERT INTO 
			Transactions (
				currency,
				amount,
				trackid,
				udf1,
				udf2,
				udf3,
				udf4,
				udf5
			) 
			VALUES (
				:currency,
				:amount,
				:trackid,
				:udf1,
				:udf2,
				:udf3,
				:udf4,
				:udf5
		)");
	
		$count->bindParam(':currency',	$currency);
		$count->bindParam(':amount', 	$amount);
		$count->bindParam(':trackid',	$trackid);
		$count->bindParam(':udf1',		$udf1);
		$count->bindParam(':udf2',		$udf2);
		$count->bindParam(':udf3',		$udf3);
		$count->bindParam(':udf4',		$udf4);
		$count->bindParam(':udf5',		$udf5);

		$count->execute();
		$dbh = null;
	}
	catch (PDOException $e) {
		print "Error!: " . $e->getMessage() . "<br/>";
		die();
	}
	
	$postfields = array(
		respurl => 'http://travellers-palm.com/success.php',
		errurl => 'http://travellers-palm.com/error.php',
		rsrcpath => '/home/tpcom/traveljadoo/conf/' . $params[$udf5]['merchantid'] . '/',
		alias => $params[$udf5]['terminalid'],
		currency => $params[$udf5]['hdfccode'],
		amount => $amount,
		trackid => 'CASM-' . $trackid,
		udf1 => $udf1,
		udf2 => $udf2,
		udf3 => $udf3,
		udf4 => $udf4,
		udf5 => $udf5
	);
	$fields_string = '';
	foreach( $postfields as $key=>$value ) { $fields_string .= $key . '=' . urlencode($value) . '&'; }
	rtrim($fields_string,'&');
	
	$ch = curl_init();

	//set the url, number of POST vars, POST data
	curl_setopt($ch, CURLOPT_URL, 'http://localhost:8080/checkout/passthrough.php');
	curl_setopt($ch, CURLOPT_POST, count($postfields));
	curl_setopt($ch,CURLOPT_POSTFIELDS,$fields_string);


	//execute post
	$result = curl_exec($ch);
	echo $result;

	//close connection
	curl_close($ch);
?>	

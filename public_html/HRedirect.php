<?php

$ErrorTx = isset($_POST['Error']) ? $_POST['Error'] : '';
$ErrorResult = isset($_POST['ErrorText']) ? $_POST['ErrorText'] : '';
$payID = isset($_POST['paymentid']) ? $_POST['paymentid'] : '';
// IMPORTANT NOTE - MERCHANT SHOULD SECURE THE RESPONSE RECEIVED FROM PAYMENT GATEWAY ON THIS PAGE
if ($ErrorTx == '')
	{
		$amount = isset($_POST['amt']) ? $_POST['amt'] : '';
		$result = isset($_POST['result']) ? $_POST['result'] : '';
		$postdate = isset($_POST['postdate']) ? $_POST['postdate'] : '';
		$tranid = isset($_POST['tranid']) ? $_POST['tranid'] : '';
		$auth = isset($_POST['auth']) ? $_POST['auth'] : '';
		$trackid = isset($_POST['trackid']) ? $_POST['trackid'] : '';
		$udf1 = isset($_POST['udf1']) ? $_POST['udf1'] : '';

	//$myFile = $tranid ."TestFile.txt";
	$myFile = "/tmp/HDFCLog.txt";
	$fh = fopen($myFile, 'w') or die("can't open file");

fwrite($fh, $result);
fwrite($fh, "|");
fwrite($fh, $postdate);
fwrite($fh, "|");
fwrite($fh, $tranid);
fwrite($fh, "|");
fwrite($fh, $auth);
fwrite($fh, "|");
fwrite($fh, $trackid);
fwrite($fh, "|");
fwrite($fh, $amount);


fclose($fh);
 echo $amount;

// 		$REDIRECT = 'REDIRECT=http://travellers-palm.com/HResult.php?paymentid=' .
// 						 $payID .
// 						 '&result=' .
// 						 $result .
// 						 '&postdate=' .
// 						 $postdate .
// 						 '&tranid=' .
// 						 $tranid .
// 						 '&auth=' .
// 						 $auth .
// 						 '&trackid=' .
// 						 $trackid.
// 						'&udf1=' .
// 						 $udf1 .
// 						'&amt=' .
// 						 $amount;
// 							;



// 		echo $REDIRECT;
// 	}
// 	else
// 		{
// 			$REDIRECT = 'REDIRECT=http://travellers-palm.com/HResult.php?paymentid=' .
// 							$payID .
// 							'&result=' .
// 							$ErrorResult;
// 			echo $REDIRECT;
// 		}
?>

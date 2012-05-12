<?php
$s = isset($_GET['result']) ? $_GET['result'] : '';
$amount = isset($_GET['amt']) ? $_GET['amt'] : '';
$postdate = isset($_GET['postdate']) ? $_GET['postdate'] : '';
$tranid = isset($_GET['tranid']) ? $_GET['tranid'] : '';
$auth = isset($_GET['auth']) ? $_GET['auth'] : '';
$trackid= isset($_GET['trackid']) ? $_GET['trackid'] : '';
//$udf1= isset($_GET['udf1]) ? $_GET['udf1'] : '';
$payID = isset($_GET['paymentid']) ? $_GET['paymentid'] : '';
$auth = isset($_GET['auth']) ? $_GET['auth'] : '';
$udf1 = isset($_GET['udf1']) ? $_GET['udf1'] : '';
if ($payID == '')
	{
		$failure_url = 'HError.php';
		header('Location: '. $failure_url);
		exit;
	}
if ($s != 'CAPTURED')
	{
		$failure_url = 'HError.php' . '?paymentid=' . $payID . '&result=' . $s;
		header('Location: '. $failure_url);
		exit;
	}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Colors of Success</TITLE>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<META name="GENERATOR" content="IBM WebSphere Studio">
</HEAD>
<BODY>
<CENTER>
<br><br>

<b><font color="green">ACTUAL PG RESPONSE</b></font><br>
<?
$file = "/tmp/HDFCLog.txt";
$f = fopen($file, "r");
while ( $line = fgets($f, 1000) ) {
print $line;
}
?>

<br><br>

<TABLE align=center border=1  bordercolor=black><tr><td>
		<TR>
			<TD colspan="2" align="center">
				<FONT size="4" color="blue"><B>PG Temparory Response</B></FONT>
			</TD>
		</TR>
		<TR>
			<TD>Result Code</TD>
			<TD><b><?php echo $s;?></b></TD>
		</TR>
		<TR>
			<TD width="40%">Amount</TD>
			<TD><?php echo $amount;?></TD>
		</TR>
		<TR>
			<TD width="40%">Track ID</TD>
			<TD><?php echo $trackid;?></TD>
		</TR>

		<TR>
			<TD>Payment ID</TD>
			<TD><?php echo $payID;?></TD>
		</TR>

		<TR>
			<TD>Transaction ID</TD>
			<TD><?php echo $tranid;?></TD>
		</TR>

		<TR>
			<TD>UDF1</TD>
			<TD><?php echo $udf1;?></TD>
		</TR>
		<TR>
			<TD>Post Date</TD>
			<TD><?php echo $postdate;?></TD>
		</TR>

		<TR>
			<TD>Auth Code</TD>
			<TD><?php echo $auth;?></TD>
		</TR></td></tr></table></td></tr>
		</table>
			<center><A href="HIndex.php"><p style="color:blue"><b>Enter for another Transaction</b></p></A></center>

</BODY>
</HTML>

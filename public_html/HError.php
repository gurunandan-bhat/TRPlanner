<HTML>
<HTML>
<HEAD>
<TITLE>Failure Page</TITLE>
</HEAD>
<BODY>
<center>

<b><font size=5 color="blue"> ERROR</font> </b>

<br><br><br>

<?php
echo "<font size=3 color=red>";
echo "<b><br>";
echo isset($_GET['result']) ? $_GET['result'] : '';
?>
</b>
</center>
</HTML>  



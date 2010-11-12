<p><a href="hotel.cgi?mode=search&subject=state&id=<!-- TMPL_VAR NAME=STATEID -->">Click here</a> to read about the State of <!-- TMPL_VAR NAME=STATENAME -->.</p>
<p>To read about cities in <!-- TMPL_VAR NAME=STATENAME -->, Click on any city in the list below:</p>
<div class="box">
	<ol>
		<!-- TMPL_LOOP NAME=CITIES -->
		<li><a href="hotel.cgi?mode=search&subject=city&id=<!-- TMPL_VAR NAME=CITYID -->"><!-- TMPL_VAR NAME=CITYNAME --></a></li>
		<!-- /TMPL_LOOP -->
	</ol>	
</div>

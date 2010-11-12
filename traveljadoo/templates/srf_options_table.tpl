<div id="firstoption">
	<h6>Option 1: <!-- TMPL_VAR NAME=HDR1 --></h6>
	<table width="98%">
		<tr>
			<th>Mode</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPT1 -->
		<tr>
			<td><!-- TMPL_VAR NAME=opt_method --></td>
			<td><!-- TMPL_VAR NAME=opt_source --></td>
			<td><!-- TMPL_VAR NAME=opt_destination --></td>
			<td><!-- TMPL_VAR NAME=opt_departure --></td>
			<td><!-- TMPL_VAR NAME=opt_arrival --></td>
		</tr>
		<!-- /TMPL_LOOP -->
	</table>
</div>
<!-- TMPL_IF NAME=HDR2 -->
<p class="optionmessage">While this is the best and most comfortable way to travel from <!-- TMPL_VAR NAME=FROMCITY --> to <!-- TMPL_VAR NAME=TOCITY -->, 
You may consider options shown below that either take longer or are inconvenient in other ways</p>
<div id="otheroptions">
	<div>
		<h6>Option 2: <!-- TMPL_VAR NAME=HDR2 --></h6>
		<table width="98%">
		<tr>
			<th>Mode</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPT2 -->
		<tr>
			<td><!-- TMPL_VAR NAME=opt_method --></td>
			<td><!-- TMPL_VAR NAME=opt_source --></td>
			<td><!-- TMPL_VAR NAME=opt_destination --></td>
			<td><!-- TMPL_VAR NAME=opt_departure --></td>
			<td><!-- TMPL_VAR NAME=opt_arrival --></td>
		</tr>
		<!-- /TMPL_LOOP -->
		</table>
	</div>
	<div>
		<h6>Option 3: <!-- TMPL_VAR NAME=HDR3 --></h6>
		<table width="98%">
		<tr>
			<th>Mode</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPT3 -->
		<tr>
			<td><!-- TMPL_VAR NAME=opt_method --></td>
			<td><!-- TMPL_VAR NAME=opt_source --></td>
			<td><!-- TMPL_VAR NAME=opt_destination --></td>
			<td><!-- TMPL_VAR NAME=opt_departure --></td>
			<td><!-- TMPL_VAR NAME=opt_arrival --></td>
		</tr>
		<!-- /TMPL_LOOP -->
		</table>
	</div>
</div>
<!-- /TMPL_IF -->

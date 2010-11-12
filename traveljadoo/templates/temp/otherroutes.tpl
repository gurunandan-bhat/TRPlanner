<!-- TMPL_LOOP NAME=OTHERROUTES -->
<div class="otherroutes">
	<h1><input type="radio" name="travelopts" value="<!-- TMPL_VAR NAME=OPTIONNUMBER -->" /> <!-- TMPL_VAR NAME=OPTIONHEADER --></h1>
	<table width="98%">
		<tr>
			<th>From</th><th>Departure</th><th>To</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPTIONHOPS -->
		<tr>
			<td><!-- TMPL_VAR NAME=opt_source --></td>
			<td><!-- TMPL_VAR NAME=opt_departure --></td>
			<td><!-- TMPL_VAR NAME=opt_destination --></td>
			<td><!-- TMPL_VAR NAME=opt_arrival --></td>
		</tr>
		<!-- /TMPL_LOOP -->
	</table>
</div>
<!-- /TMPL_LOOP -->

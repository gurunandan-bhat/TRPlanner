<!-- TMPL_LOOP NAME=OTHERROUTES -->
<div class="otherroutes">
	<h4><input type="radio" name="travelopts" value="<!-- TMPL_VAR NAME=OPTIONNUMBER -->" /> Tweaked Option <!-- TMPL_VAR NAME=OPTIONNUMBER -->: <!-- TMPL_VAR NAME=OPTIONHEADER --></h4>
	<table width="98%">
		<tr>
			<th>Mode</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPTIONHOPS -->
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
<!-- /TMPL_LOOP -->

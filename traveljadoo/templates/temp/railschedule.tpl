<h1>Schedule: <!-- TMPL_VAR NAME=TRAINCODE --> <!-- TMPL_VAR NAME=TRAINNAME --></h1>
<table>
	<thead><tr>
		<th>Stop</th><th>Station</th><th>Arr.</th><th>Dep.</th><th>Day</th><th>Distance</th>
	</tr></thead>
	<!-- TMPL_LOOP NAME=STOPS -->
	<tr<!-- TMPL_UNLESS NAME=__odd__ --> class="even"<!-- /TMPL_UNLESS -->>
		<td><!-- TMPL_VAR NAME=STOPNUM --></td>
		<td><!-- TMPL_VAR NAME=STOPNAME --></td>
		<td><!-- TMPL_VAR NAME=STOPARR --></td>
		<td><!-- TMPL_VAR NAME=STOPDEP --></td>
		<td><!-- TMPL_VAR NAME=STOPDAYNUM --></td>
		<td><!-- TMPL_VAR NAME=STOPDISTANCE --></td>
	</tr>
	<!-- /TMPL_LOOP -->
</table>

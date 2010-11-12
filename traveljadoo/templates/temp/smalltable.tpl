<table width="98%" class="bordered">
	<tr><th width="2%">#</th><th>Date</th><th>City</th></tr>
	<!-- TMPL_LOOP NAME=DATECAL -->
		<tr<!-- TMPL_IF NAME=__ODD__ --> class="even"<!-- /TMPL_IF -->>
			<td<!-- TMPL_IF NAME=OVERSTAYED --> class="overstayed"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=DAYNUM --></td>
			<td<!-- TMPL_IF NAME=OVERSTAYED --> class="overstayed"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=DAYDATE --></td>
			<td<!-- TMPL_IF NAME=OVERSTAYED --> class="overstayed"<!-- /TMPL_IF -->><!-- TMPL_VAR NAME=CITY --></td>
		</tr>
	<!-- /TMPL_LOOP -->
</table>
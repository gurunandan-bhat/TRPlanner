<table width="590">
	<tr><th>From</th><th>To</th><th>Room Type</th><th>AC</th><th>Meal Plan</th><th>Single</th><th>Double</th></tr>
	<!-- TMPL_LOOP NAME=TARIFF -->
	<tr>
		<td><!-- TMPL_VAR NAME=FROMDATE --></td>
		<td><!-- TMPL_VAR NAME=TODATE --></td>
		<td><!-- TMPL_VAR NAME=ROOMTYPE --></td>
		<td><!-- TMPL_VAR NAME=AC --></td>
		<td><!-- TMPL_VAR NAME=MEALPLAN --></td>
		<td><!-- TMPL_VAR NAME=SINGLE --></td>
		<td><!-- TMPL_VAR NAME=DOUBLE --></td>
	</tr>
	<!-- /TMPL_LOOP -->
</table>

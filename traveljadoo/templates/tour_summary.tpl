<h1>Your City-wise Itinerary</h1>
<table width="98%" class="bordered">
	<th></th><th>Day</th><th>Arrival</th><th>City</th>
	<!-- TMPL_LOOP NAME=CITYSTOPS -->
	<tr class="summaryrow<!-- TMPL_UNLESS NAME=__odd__ --> even<!-- /TMPL_UNLESS -->">
		<td width="14" class="indicator"><img src="images/openup.gif" width="16" height="16" /></td>
		<td width="12"><!-- TMPL_VAR NAME=CITYDAYNUMIN --></td>
		<td width="80"><!-- TMPL_VAR NAME=DATEIN --></td>
		<td><!-- TMPL_VAR NAME=CITYNAME --></td>
	</tr>
	<tr class="summarydetail">
		<td colspan="5">
			<p class="summaryhdr"><strong><!-- TMPL_VAR NAME=CITYNAME -->: Day <!-- TMPL_VAR NAME=CITYDAYNUMIN --> to <!-- TMPL_VAR NAME=CITYDAYNUMOUT --></strong></p>
			<p><img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/city_<!-- TMPL_VAR NAME=CITYID -->_movingon.jpg" height="63" width="100" />
			<!-- TMPL_VAR NAME=CITYDESC --> You will stay at "<!-- TMPL_VAR NAME=CITYHOTEL -->" for <!-- TMPL_VAR NAME=CITYNIGHTS --> nights</p>
			<p>You will leave <!-- TMPL_VAR NAME=CITYNAME --> on <!-- TMPL_VAR NAME=DATEOUT --></p>
		</td>
	</tr>
	<!-- /TMPL_LOOP -->
</table>

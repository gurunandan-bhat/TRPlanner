<form id="searchunit" action="/search" method="post">
	<table>
		<tr>
			<td class="headline">Quick Search</td>
			<td colspan="2"><input type="text" id="byname" name="hotelname" value="Enter Hotel Name"  style="font-size: 10px;" /> <input type="submit"  style="font-size: 10px;" value="Go" /></td>
		</tr>
		<tr>
			<td>
				<select name="state" id="state" class="left bystate" style="font-size: 10px;">
					<option value="0" selected="selected">Choose a State...</option>
					<!-- TMPL_LOOP NAME=STATES -->
					<option value="<!-- TMPL_VAR NAME=STATEURL -->"><!-- TMPL_VAR NAME=STATE --></option>
					<!-- /TMPL_LOOP -->
				</select>
			</td>
			<td>OR</td>
			<td>
				<select name="state" id="state" class="bycity" style="font-size: 10px;">
					<option value="0" selected="selected">Choose a City...</option>
					<!-- TMPL_LOOP NAME=CITIES -->
						<option value="<!-- TMPL_VAR NAME=CITYURL -->"><!-- TMPL_VAR NAME=CITY --></option>
					<!-- /TMPL_LOOP -->
				</select>
			</td>
		</tr>
	</table>
</form>

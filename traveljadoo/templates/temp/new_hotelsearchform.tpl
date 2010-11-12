<form id="searchunit" action="#" method="post">
	<fieldset>
		<legend>Search Box</legend>
		<label for="keyword">Quick Search: </label>
		<input type="text" id="keyword" name="keyword" value="Enter Hotel Name" /><br />
		<select name="state" id="state" class="left">
			<option value="0" selected="selected">Choose a State...</option>
			<!-- TMPL_LOOP NAME=STATES -->
				<option value="<!-- TMPL_VAR NAME=STATEID -->"><!-- TMPL_VAR NAME=STATE --></option>
			<!-- /TMPL_LOOP -->
		</select>
		<select name="state" id="state">
			<option value="0" selected="selected">Choose a City...</option>
			<!-- TMPL_LOOP NAME=CITIES -->
				<option value="<!-- TMPL_VAR NAME=CITYID -->"><!-- TMPL_VAR NAME=CITY --></option>
			<!-- /TMPL_LOOP -->
		</select>
	</fieldset>
</form>

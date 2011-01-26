<form id="searchunit" action="#" method="post">
	<fieldset>
		<legend>Select your next destination</legend>
		<label for="keyword">Other Cities: </label>
		<select id="keyword" name="desturl">
		<!-- TMPL_LOOP NAME=RANDOMDESTINATION -->
			<option value="<!-- TMPL_VAR NAME=BASEPREFIX -->travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=RANDOMDESTID -->"><!-- TMPL_VAR NAME=RANDOMDESTNAME --></option>
		<!-- /TMPL_LOOP -->
		</select>
	</fieldset>
</form>

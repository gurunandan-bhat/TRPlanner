<form class="nextcity" method="post" action="travel.cgi" style="display: inline;">
		<select id="desturl" name="desturl">
		<!-- TMPL_LOOP NAME=RANDOMDESTINATION -->
			<option value="travel.cgi?mode=move_to&srcid=<!-- TMPL_VAR NAME=CURRID -->&destid=<!-- TMPL_VAR NAME=RANDOMDESTID -->"><!-- TMPL_VAR NAME=RANDOMDESTNAME --></option>
		<!-- /TMPL_LOOP -->
		</select>
		<input type="submit" value="Go!" />
		<input type="hidden" name="mode" value="randomcity" />
</form>

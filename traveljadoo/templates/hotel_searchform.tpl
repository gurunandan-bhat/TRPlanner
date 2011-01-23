<div class="hotelsearch">
	<form id="hotelssearch" method="post" action="<!-- TMPL_VAR NAME=BASEPREFIX -->hotel.cgi">
		<select class="bystate" name="id" size="1">
			<option value="0" selected="selected">Search Hotels by State...</option>
			<!-- TMPL_LOOP NAME=STATES -->
				<option value="<!-- TMPL_VAR NAME=STATEID -->"><!-- TMPL_VAR NAME=STATE --></option>
			<!-- /TMPL_LOOP -->
		</select>
		<select class="bycity" name="id" size="1">
			<option value="0" selected="selected">Search Hotels by City...</option>
			<!-- TMPL_LOOP NAME=CITIES -->
				<option value="<!-- TMPL_VAR NAME=CITYID -->"><!-- TMPL_VAR NAME=CITY --></option>
			<!-- /TMPL_LOOP -->
		</select>
	</form>
</div>

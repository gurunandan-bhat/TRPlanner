<div id="firstoption">
	<h4><input type="radio" name="travelopts" value="1" checked="checked" /> Option 1: <!-- TMPL_VAR NAME=HDR1 --></h4>
	<table width="98%">
		<tr>
			<th>Mode</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPT1 -->
		<tr>
			<td><!-- TMPL_VAR NAME=opt_method --></td>
			<td><!-- TMPL_VAR NAME=opt_source --></td>
			<td><!-- TMPL_VAR NAME=opt_destination --></td>
			<td><!-- TMPL_VAR NAME=opt_departure --></td>
			<td><!-- TMPL_VAR NAME=opt_arrival --></td>
		</tr>
		<!-- /TMPL_LOOP -->
	</table>
	<!-- TMPL_IF NAME=HASTRAIN1 -->
	<p class="tweak"><a href="<!-- TMPL_VAR NAME=LINK1 -->">Tweak this Option</a></p>
	<p class="throbber">Please Wait - Fetching Options....</p>
	<div class="otheroptions"></div>
	<!-- /TMPL_IF -->
</div>
<!-- TMPL_IF NAME=HDR2 -->
<p class="optionmessage">While this is the best and most comfortable way to travel from <!-- TMPL_VAR NAME=FROMCITY --> to <!-- TMPL_VAR NAME=TOCITY -->, 
You may <a href="#" id="showmoreopts">Click Here</a> to toggle other options that either take longer or are inconvenient in other ways</p>
<div id="otheroptions">
	<div>
		<h4><input type="radio" name="travelopts" value="2" /> Option 2 <!-- TMPL_VAR NAME=HDR2 --></h4>
		<table width="98%">
		<tr>
			<th>Mode</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPT2 -->
		<tr>
			<td><!-- TMPL_VAR NAME=opt_method --></td>
			<td><!-- TMPL_VAR NAME=opt_source --></td>
			<td><!-- TMPL_VAR NAME=opt_destination --></td>
			<td><!-- TMPL_VAR NAME=opt_departure --></td>
			<td><!-- TMPL_VAR NAME=opt_arrival --></td>
		</tr>
		<!-- /TMPL_LOOP -->
		</table>
		<!-- TMPL_IF NAME=HASTRAIN2 -->
		<p class="tweak"><a href="<!-- TMPL_VAR NAME=LINK2 -->">Tweak this Option</a></p>
		<p class="throbber">Please Wait - Fetching Options....</p>
		<div class="otheroptions"></div>
		<!-- /TMPL_IF -->
	</div>
	<div>
		<h4><input type="radio" name="travelopts" value="3" /> Option 3 <!-- TMPL_VAR NAME=HDR3 --></h4>
		<table width="98%">
		<tr>
			<th>Mode</th><th>From</th><th>To</th><th>Departure</th><th>Arrival</th>		
		</tr>
		<!-- TMPL_LOOP NAME=OPT3 -->
		<tr>
			<td><!-- TMPL_VAR NAME=opt_method --></td>
			<td><!-- TMPL_VAR NAME=opt_source --></td>
			<td><!-- TMPL_VAR NAME=opt_destination --></td>
			<td><!-- TMPL_VAR NAME=opt_departure --></td>
			<td><!-- TMPL_VAR NAME=opt_arrival --></td>
		</tr>
		<!-- /TMPL_LOOP -->
		</table>
		<!-- TMPL_IF NAME=HASTRAIN3 -->
		<p class="tweak"><a href="<!-- TMPL_VAR NAME=LINK3 -->">Tweak this Option</a></p>
		<p class="throbber">Please Wait - Fetching Options....</p>
		<div class="otheroptions"></div>
		<!-- /TMPL_IF -->
	</div>
</div>
<!-- /TMPL_IF -->

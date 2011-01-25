<h3>Quick Links</h3>
<ul>
	<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes/">Incredible India</a>
		<ul>
			<!-- TMPL_LOOP NAME=THEMES -->
			<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->themes/<!-- TMPL_VAR NAME=THEMEURL -->"><!-- TMPL_VAR NAME=THEMENAME --></a></li>
			<!-- /TMPL_LOOP -->
		</ul>
	</li>
	<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/">Mini Itineraries</a>
		<ul>
			<!-- TMPL_LOOP NAME=REGIONS -->
			<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->modules/<!-- TMPL_VAR NAME=REGIONURL -->"><!-- TMPL_VAR NAME=REGIONNAME --></a></li>
			<!-- /TMPL_LOOP -->
		</ul>
	</li>
	<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tours">Indian Journeys</a>
		<ul>
			<!-- TMPL_LOOP NAME=TOURS -->
			<li><a href="<!-- TMPL_VAR NAME=BASEPREFIX -->tourdetails/<!-- TMPL_VAR NAME=TOURURL -->"><!-- TMPL_VAR NAME=TOURNAME --></a></li>
			<!-- /TMPL_LOOP -->
		</ul>
	</li>
</ul>

<h3>Quick Links</h3>
<ul>
	<li><a href="/themes/">Incredible India</a>
		<ul>
			<!-- TMPL_LOOP NAME=THEMES -->
			<li><a href="/themes/<!-- TMPL_VAR NAME=THEMEURL -->"><!-- TMPL_VAR NAME=THEMENAME --></a></li>
			<!-- /TMPL_LOOP -->
		</ul>
	</li>
	<li><a href="/modules/">Mini Itineraries</a>
		<ul>
			<!-- TMPL_LOOP NAME=REGIONS -->
			<li><a href="/modules/<!-- TMPL_VAR NAME=REGIONURL -->"><!-- TMPL_VAR NAME=REGIONNAME --></a></li>
			<!-- /TMPL_LOOP -->
		</ul>
	</li>
	<li><a href="/tours">Indian Journeys</a>
		<ul>
			<!-- TMPL_LOOP NAME=TOURS -->
			<li><a href="/tourdetails/<!-- TMPL_VAR NAME=TOURURL -->"><!-- TMPL_VAR NAME=TOURNAME --></a></li>
			<!-- /TMPL_LOOP -->
		</ul>
	</li>
</ul>

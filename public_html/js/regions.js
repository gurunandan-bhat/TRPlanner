/**
 * @author guru
 */
$(document).ready(function() {

	var baseprefix = $('body').attr('baseprefix');

	var regions = 9;
	var reglat = new Array (
		26.92555556,
		32.28555556,
		24.63750000,
		23.02166667,
		18.999803,
		13.05027778,
		8.36944444,
		11.63722222,
		10.951111
	);
	var reglng = new Array (
		75.82361111,
		77.16222222,
		87.84861100,
		72.59027778,
		72.817383,
		80.23222222,
		77.00444444,
		92.72805556,
		72.287778
	);

	var india = new google.maps.LatLng(22.268764, 81.474609);
	var mapOptions = {
		zoom: 4,
		center: india,
		mapTypeControl: false,
		mapTypeId: google.maps.MapTypeId.TERRAIN
	};

	var myMap = new google.maps.Map(document.getElementById("thememap"), mapOptions);

	var mymarkers = new Array();
	var lstnrs = new Array();
	var modulename = new Array();

	$.getJSON(baseprefix + 'modules/list', function(data) {
		var modcount = data.count;
		for (i = 0; i < modcount; i++) {
			var idx = i + 1;
			mymarkers[i] = new google.maps.Marker({
				position: new google.maps.LatLng(reglat[i], reglng[i]),
				map: myMap,
				icon: 'markers/image_' + idx + '.png',
				region: idx
			});
			set_redirector(mymarkers[i], data.modules[i], baseprefix);
		}
	});
});

function set_redirector(marker, idx, prefix) {
	google.maps.event.addListener(
		marker, 
		'click', 
		function() {
			window.location = prefix + 'modules/' + idx;
		}
	);
}

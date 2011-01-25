/**
 * @author guru
 */
$(document).ready(function() {

	var baseprefix = $('body').attr('baseprefix');
	
	var india = new google.maps.LatLng(23.268764, 81.474609);
	var mapOptions = {
		zoom: 4,
		center: india,
		mapTypeControl: false,
		mapTypeId: google.maps.MapTypeId.TERRAIN
	};
	var myMap = new google.maps.Map(document.getElementById("thememap"), mapOptions);

	var myMarkers = new Array();
	var myListeners = new Array();
	var currsubtheme = 0;


	$("form#subthemelist input").click(function() {

		myMap.panTo(india);
		var subthemeid = $(this).attr('value');
		var added;
		
		if (currsubtheme > 0) {
			var arrlen = myMarkers[currsubtheme].length;
			for (var i = 0; i < arrlen; ++i) {

				var lstnr = myListeners[currsubtheme].pop();
				google.maps.event.removeListener(lstnr);
				
				var marker = myMarkers[currsubtheme].pop();
				marker.setMap(null);
			}
			delete myListeners[currsubtheme];
			delete myMarkers[currsubtheme];
		}

		$(this).parent('li').append('<span><img src="' + baseprefix + 'images/ajax-loader.gif" width="16" height="16" />Getting...</span>');
		added = $(this).siblings('span');

		var uri = baseprefix + 'themes/themename/' + subthemeid;
		$.getJSON(
			uri,
			function (data) {

				myMarkers[subthemeid] = new Array();
				myListeners[subthemeid] = new Array();
				
				$.each(data.mapcities, function(i, city) {
					var marker = new google.maps.Marker({
						position: new google.maps.LatLng(this.lat, this.lng),
						map: myMap,
						title: this.name,
						cityid: this.id
					});
					myMarkers[subthemeid].push(marker);
					
					var lstnr = google.maps.event.addListener(
						marker, 
						'click', 
						function() {
							$.get(
								uri + '/' + this.cityid,
								function(data) {
									$('#themecitydesc').html(data);
									$('#themedesc').html('');
								}
							);
						}
					);
					myListeners[subthemeid].push(lstnr);
				});
				$('#themecitydesc').html('');
				$('#themedesc').html('<h1>' + data.subthemename + '</h1><p>' + data.subthemedesc + '</p>');
				added.remove();
			}
		);
		currsubtheme = subthemeid;
	});

});

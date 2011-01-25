$(document).ready(function() {

	var baseprefix = $('body').attr('baseprefix');

	var india = new google.maps.LatLng(22.268764, 81.474609);
	var mapOptions = {
		zoom: 4,
		center: india,
		mapTypeControl: false,
		mapTypeId: google.maps.MapTypeId.TERRAIN
	};

	var myMap = new google.maps.Map(document.getElementById("thememap"), mapOptions);
	
	$.getJSON('hotel.cgi', {mode: 'hotelstates'}, function(data) {

		for (var i = 0; i < data.length; i++) {

			var id = data[i].id;
			var name = data[i].name;
			var lat = data[i].lat;
			var lng = data[i].lng;

			var desc = data[i].desc;
			var desc = '<div style="width: 240px;"><h3>' + name + '</h3><p class="mappopup"><img style="margin-top: 0;" class="left" src="' + baseprefix + 'images/state_' + id + '_small.jpg" width="120" height="75" /> ' + desc + '<br /><a href="hotel.cgi?mode=search&subject=state&id=' + id + '">More...</a></p>';

			var marker = new google.maps.Marker({
				position: new google.maps.LatLng(lat, lng),
				map: myMap,
				title: name
			});
			
			attachInfoWndwEvent(marker, desc);
		}
	});
	
	function attachInfoWndwEvent (marker, desc) {
		
		var infowndw = new google.maps.InfoWindow({  
			content: desc  
		});
		google.maps.event.addListener(marker, 'click', function() {  
			infowndw.open(myMap, marker);  
		});  			
	}
})



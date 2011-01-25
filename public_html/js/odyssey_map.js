/**
 * @author guru
 */

 $(document).ready(function() {

	var baseprefix = $('body').attr('baseprefix');

	var currentCityId = $('#big_map').attr('thiscity');
	var lat = $('#big_map').attr('lat');
	var lng = $('#big_map').attr('lng');

	if (GBrowserIsCompatible()) {
		var map = new GMap2(document.getElementById("big_map"));
		var city =  new GLatLng(lat, lng);
		map.setCenter(city, 7);
		map.setUIToDefault();
		map.removeControl(GSmallMapControl);
		map.removeControl(GMapTypeControl);
		

		var oIcon = new GIcon();
		oIcon.image = "http://www.travellers-palm.com/beta/images/marker1.png";
		oIcon.iconSize = new GSize(17,25);
		oIcon.iconAnchor = new GPoint(8, 25);
		oIcon.transparent = "http://www.travellers-palm.com/beta/images/marker_trans1.png";
		oIcon.infoWindowAnchor = new GPoint(8, 2);
		oIcon.imageMap = [9,0,6,1,5,2,4,2,3,4,3,5,2,8,3,10,5,12,5,13,6,14,6,23,9,23,8,16,9,15,10,14,10,12,11,11,12,10,12,4,12,3,10,1,9,0];

		var mIcon = new GIcon();
		mIcon.image = "http://www.travellers-palm.com/beta/images/marker2.png";
		mIcon.iconSize = new GSize(17,25);
		mIcon.iconAnchor = new GPoint(8, 25);
		mIcon.transparent = "http://www.travellers-palm.com/beta/images/marker_trans2.png";
		mIcon.infoWindowAnchor = new GPoint(8, 2);
		mIcon.imageMap = [9,0,6,1,5,2,4,2,3,4,3,5,2,8,3,10,5,12,5,13,6,14,6,23,9,23,8,16,9,15,10,14,10,12,11,11,12,10,12,4,12,3,10,1,9,0];

		function createMarker(point, html, type) {
			var myIcon = (type == 'o') ? oIcon : mIcon;
			var marker = new GMarker(point, myIcon);
			GEvent.addListener(marker, "mouseover", function() {
				marker.openInfoWindowHtml(html);
			});
			return marker;
		}

		$.getJSON(baseprefix + 'travel.cgi', {mode: 'getmapcities'}, function(data) {

			for (var i = 0; i < data.length; i++) {
				var id = data[i].id;
				var city = data[i].city;
				var oneliner = data[i].oneliner;
				var tmpcity = new GLatLng(data[i].latitude, data[i].longitude);

				var desc = '<div style="width: 240px;"><h2>' + city + '</h2><p class="mappopup"><img src="' + baseprefix + 'images/city_' + id + '_movingon.jpg" height="75" width="120" />' + oneliner + '</p>';
				desc = desc + '<p class="mappopup">Click <a href="' + baseprefix + 'travel.cgi?mode=move_to&srcid=' + currentCityId + '&destid=' + id + '">here</a> to go to ' + city + '</p></div>'

				var marker = (id == currentCityId) ? createMarker(tmpcity, desc, 'm') : createMarker(tmpcity, desc, 'o');

				map.addOverlay(marker);
			}
		});
		
		$.getJSON('travel.cgi', {mode: 'getmappath', dummy: new Date().getTime()}, function(data) {
			var llpoints = [];
			for (var i = 0; i < data.length; i++) {
				llpoints[i] = new GLatLng(parseFloat(data[i].latitude), parseFloat(data[i].longitude));
			}
			map.addOverlay(new GPolyline(llpoints));
		});
	}
})


$(document.body).unload(function() {
	if (GBrowserIsCompatible()) {
		GUnload();
	}
})


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
		oIcon.image = "http://travellers-palm.com/images/marker1.png";
		oIcon.iconSize = new GSize(17,25);
		oIcon.iconAnchor = new GPoint(8, 25);
		oIcon.transparent = "http://travellers-palm.com/odyssey/images/marker_trans1.png";
		oIcon.infoWindowAnchor = new GPoint(8, 2);
		oIcon.imageMap = [9,0,6,1,5,2,4,2,3,4,3,5,2,8,3,10,5,12,5,13,6,14,6,23,9,23,8,16,9,15,10,14,10,12,11,11,12,10,12,4,12,3,10,1,9,0];

		var mIcon = new GIcon();
		mIcon.image = "http://travellers-palm.com/odyssey/images/marker2.png";
		mIcon.iconSize = new GSize(17,25);
		mIcon.iconAnchor = new GPoint(8, 25);
		mIcon.transparent = "http://travellers-palm.com/odyssey/images/marker_trans2.png";
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

		var marker = createMarker(city, '<p>Some Text Here</p>', 'm');
		map.addOverlay(marker);
	}
})


$(document.body).unload(function() {
	if (GBrowserIsCompatible()) {
		GUnload();
	}
})


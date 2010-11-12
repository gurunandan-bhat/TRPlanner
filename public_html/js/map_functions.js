/* [listing 2-8] */
var centerLatitude = 21.09;
var centerLongitude = 79.09;
var startZoom = 4;

var map;

function addMarker(latitude, longitude, description) {
    var marker = new GMarker(new GLatLng(latitude, longitude));

    GEvent.addListener(marker, 'click',
        function() {
            marker.openInfoWindowHtml(description);
        }
    );

    map.addOverlay(marker);
}

function init() {
    if (GBrowserIsCompatible()) {	
        map = new GMap2(document.getElementById("map"));
        map.addControl(new GSmallMapControl());
        map.setCenter(new GLatLng(centerLatitude, centerLongitude), startZoom);

        for(id in markers) {
            addMarker(markers[id].latitude, markers[id].longitude, markers[id].name);
        }
    }
}

window.onload = init;
window.onunload = GUnload;
/* [listing 2-8 end] */
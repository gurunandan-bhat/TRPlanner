function showdetails(stateid) {
	$('#details').html("Please Wait. Fetching Data...");
	$.get('hotel.cgi', {
		'mode': 'showdetails',
		'stateid': stateid
		},
		function(data) {
			$('#details').html(data);
		}
	);
}

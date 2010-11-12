$(document).ready(function() {
	
	$('form#trainslist input').click(function() {

		$('div#detailschedule').html('');
		$('p#schedulethrobber').show();

		var train = $(this).attr('value');
		$.get('rail.cgi', {'mode': 'getschedule', 'shortname': train}, function(data) {
			$('p#schedulethrobber').hide();
			$('div#detailschedule').html(data);
		});

	});
})

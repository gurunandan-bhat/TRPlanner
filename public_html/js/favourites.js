$(document).ready(function() {
	
	var baseprefix = $('body').attr('baseprefix');
	
	$('form#register').hide();
	
	$('p.fav a#addtofav').click(function() {

		var favtype = $(this).attr('type');
		var favid = $(this).attr('objid');
		var registered = $(this).attr('registered');

		if (!registered ) {
			$('form#register').show('slow');
			return false;
		}
		$.getJSON(baseprefix + 'old_index.cgi', {
				'mode': 'protected_save_favourites',
				'favtype': favtype,
				'favid': favid,
				'registered': registered
			},
			function(data) {
				if (data.validuser) {
					$('p.fav').html('Added to your favourites. Click <a href="/my-travellers-palm">here</a> to view your favourites');
				}
				else {
					$('form#register').show('slow');
				}
			}
		);

		return false;
	});

	$('form#register input#registernow').click(function() {
		
		var email = $('input#emailaddr').attr('value');
		var favtype = $('a#addtofav').attr('type');
		var favid = $('a#addtofav').attr('objid');
		$.getJSON(baseprefix + 'old_index.cgi', {
				'mode': 'protected_save_favourites',
				'username': email,
				'favtype': favtype,
				'favid': favid
			},
			function(data) {
				if (data.validuser) {
					$('p.fav').html('Added to your favourites. Click <a href="' + baseprefix + 'my-travellers-palm">here</a> to view your favourites');
					$('form#register').hide('slow');
				}
				else {
					$('form#register').show('slow');
				}
			}
		);

		return false;
	});
	
	$('p.addquote a').click(function() {

		var itinid = $(this).attr('itinid');

		$.getJSON(location.pathname, {
				'mode': 'save_quotes',
				'itinid': itinid
			},
			function(data) {
				if (data.loggedin) {
					$('p.addquote').hide();
					$('p.showquote').html('Added this Itinerary to your quotation basket(' + data.quotecount + '). Click <a href="' + location.pathname + '?mode=quotes&from=' + data.from + '">here</a> to view your basket');
				}
				else {
					var params = '&itinid=' + itinid;
					params += '&from=' + encodeURIComponent(window.location.href);
					window.location = 'itineraries.cgi?mode=protected_save_quotes' + params;
				}
			}
		);

		return false;
	});
})

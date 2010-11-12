$(document).ready(function() {

	$('p.throbber').hide();
	
	$('p.tweak a').click(function() {

		var firstp = $(this).parent('p.tweak');
		firstp.next('p.throbber').show();

		var opthref = $(this).attr('href');
		
		$.get(opthref, function(data) {
			firstp.next('p.throbber').hide();
			firstp.hide();
			firstp.siblings('div.otheroptions').html(data);
		});	

		return(false);
	});
});

$(document).ready(function() {

	$('#issuedon0').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});
	$('#expireson0').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});

	$('#planatrip').validate({
		rules: {
			pax: {required: true},
			name0: {required: true},
			nationality0: {required: true},
			passport0: {required: true},
			issuedon0: {required: true},
			issuedat0: {required: true},
			expireson0: {required: true},
			address: {required: true},
			email: {required: true, email: true},
			travelemail: {required: true, email: true},
			telehome: {required: true},
			ecorrname: {required: true},
			eemail: {required: true, email: true},
			etelehome: {required: true},
			etelecell: {required: true},
			haveread: {required: true},
			goodhealth: {required: true}
		}
	});
	
	var paxform = '<p class="paxnumber">Details of Traveller {{nextpax}}</p>' +
					'<ol id="pax{{currpax}}">' + 
						'<li><label for="name{{currpax}}">Name (as on passport):</label><input type="text" id="name{{currpax}}" name="name{{currpax}}" /></li>' +
						'<li><label for="nationality{{currpax}}">Nationality:</label><input type="text" id="nationality{{currpax}}" name="nationality{{currpax}}" /></li>' +
						'<li><label for="passport{{currpax}}">Passport No:</label><input type="text" id="passport{{currpax}}" name="passport{{currpax}}" /></li>' +
						'<li><label for="issuedat{{currpax}}">Place of Issue:</label><input type="text" id="issuedat{{currpax}}" name="issuedat{{currpax}}" /></li>' + 
						'<li><label for="issuedon{{currpax}}">Passport Issue Date:</label><input type="text" id="issuedon{{currpax}}" name="issuedon{{currpax}}" /></li>' +
						'<li><label for="expireson{{currpax}}">Passport Expiry Date:</label><input type="text" id="expireson{{currpax}}" name="expireson{{currpax}}" /></li>' + 
					'</ol>';
	
	var lastpax = 1;
	var maxpax = parseInt($('form#planatrip').attr('maxpax'));
	$('p#paxadder a').click(function() {
		
		var data = {
			currpax: lastpax,
			nextpax: lastpax + 1
		};

		$('p#paxadder').before(Mustache.to_html(paxform, data));
		
		$('#issuedon' + lastpax).datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});
		$('#expireson' + lastpax).datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});

		$('#name' + lastpax).rules('add', {required: true});
		$('#nationality' + lastpax).rules('add', {required: true});
		$('#passport' + lastpax).rules('add', {required: true});
		$('#issuedon' + lastpax).rules('add', {required: true});
		$('#issuedat' + lastpax).rules('add', {required: true});
		$('#expireson' + lastpax).rules('add', {required: true});

		lastpax++;
		if (lastpax == maxpax) {
			$('p#paxadder').html('');
		}

		
		return false;
	});
	
	$('form#planatrip').submit(function() {
		
		if (lastpax < maxpax) {
			
			alert('This tour has ' + maxpax + ' travellers. You have entered details of ' + lastpax + ' traveller(s) only. Please enter details of the remaining travellers in the "Details of your Party" before submitting');
			return false;
		}
	});
})

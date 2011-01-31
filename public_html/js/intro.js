/**
 * @author guru
 */

 $(document).ready(function() {

	
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

	var paxform = '<ol id="pax{{currpax}}">' + 
					'<li><label for="name{{currpax}}">Your Name (as on your passport):</label><input type="text" id="name{{currpax}}" name="name{{currpax}}" /></li>' +
					'<li><label for="nationality{{currpax}}">Nationality:</label><input type="text" id="nationality{{currpax}}" name="nationality{{currpax}}" /></li>' +
					'<li><label for="passport{{currpax}}">Passport No:</label><input type="text" id="passport{{currpax}}" name="passport{{currpax}}" /></li>' +
					'<li><label for="issuedat{{currpax}}">Place of Issue:</label><input type="text" id="issuedat{{currpax}}" name="issuedat{{currpax}}" /></li>' + 
					'<li><label for="issuedon{{currpax}}">Passport Issue Date:</label><input type="text" id="issuedon{{currpax}}" name="issuedon{{currpax}}" /></li>' +
					'<li><label for="expireson{{currpax}}">Passport Expiry Date:</label><input type="text" id="expireson{{currpax}}" name="expireson{{currpax}}" /></li>' + 
				'</ol>';
})

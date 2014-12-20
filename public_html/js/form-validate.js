$(document).ready(function() {

	$('#planatrip').validate({
		rules: {
			name1: {required: true},
			corraddress1: {required: true},
			corrcity: {required: true},
			corrzip: {required: true},
			corrcountry: {required: true},
			corremail: {required: true, email: true},
			haveread: {required: true},
			goodhealth: {required: true}
		}
	});
});
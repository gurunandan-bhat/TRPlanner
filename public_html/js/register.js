$(document).ready(function() {
	
	$('#register').validate({
		rules: {
			name: {
				required: true,
				maxlength: 48
			},
			email: {
				required: true,
				email: true
			},
			passwd1: {
				required: true,
				minlength: 4,
				maxlength: 20
			},
			passwd2: {
				required: true,
				minlength: 4,
				maxlength: 20,
				equalTo: '#passwd1'				
			},
			country: {
				required: true
			}
		}
	});
})

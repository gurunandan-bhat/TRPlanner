$(document).ready(function() {
	
	$('#newpasswd').validate({
		rules: {
			userid: {
				required: true,
				email: true
			}
		}
	});
})

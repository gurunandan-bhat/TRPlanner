$(document).ready(function() {
	
	$('#planatrip').validate({
		rules: {
			leadname: {
				required: true
			},
			arrdate: {
				required: true
			},
			arrtimehh: {
				required: true,
			},
			arrtimemm: {
				required: true,
			},
			depdate: {
				required: true
			}
		}
	});
})

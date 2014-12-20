$(document).ready(function() {

	$('#arrdate').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});
	$('#depdate').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});

	$('#planatrip').validate({
		rules: {
			corrname: {required: true},
			corraddress1: {required: true},
			corrcity: {required: true},
			corrzip: {required: true},
			corrstate: {required: true},
			corrcountry: {required: true},
			corremail: {required: true, email: true},
			travelemail: {required: true, email: true},
			telehome: {required: true},
			ename: {required: true},
			eemail: {required: true, email: true},
			etelehome: {required: true},
			etelecell: {required: true},
			haveread: {required: true},
			goodhealth: {required: true}
		}
	});
	
	var maxpax = parseInt($('form#planatrip').attr('maxpax'));
	for(i = 0; i < maxpax; i++) {
		var idx = i + 1;
		$('#name' + idx).rules('add', {required: true});
		$('#nationality' + idx).rules('add', {required: true});
		$('#issuedon' + idx).datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});
		$('#expireson' + idx).datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true});
	}
});

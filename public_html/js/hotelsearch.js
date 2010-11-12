$(document).ready(function() {

	$('select.bystate').change(function() {
		var state = this.value;
		if (state == 0) {
			return false;
		}
		window.location = '/state/' + state;
	});
	
	$('select.bycity').change(function() {
		var city = this.value;
		if (city == 0) {
			return false;
		}
		window.location = '/city/' + city;
	})
	
	$('input#byname').focus(function() {
		if ($(this).attr('value') == 'Enter Hotel Name') {
			$(this).attr('value', '');
		}
	})
	
	$('input#byname').blur(function() {
		if ($(this).attr('value') == '') {
			$(this).attr('value', 'Enter Hotel Name');
		}
	})
})

$(document).ready(function() {
	
		$('#quote-submit').click(function() {
			if ($(':checked').length == 0) {
				$('#quote-submit').before('<p class="error">You must select at least one Tour or Module to request a quote</p>');
				return false;
			}
			return true;
		});
	}
)

/**
 * @author guru
 */

 $(document).ready(function() {
	$('#issuedon').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true, onSelect: function() {} });
	$('#expireson').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true, onSelect: function() {}});
})

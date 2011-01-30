/**
 * @author guru
 */

 $(document).ready(function() {
	$('#issuedon0').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true, onSelect: function() {} });
	$('#expireson0').datepicker({dateFormat: 'dd M yy', yearRange: '-10:+10', changeYear: true, showStatus: true, onSelect: function() {}});
})

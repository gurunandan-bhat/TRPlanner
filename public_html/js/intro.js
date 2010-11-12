/**
 * @author guru
 */

 $(document).ready(function() {
	$("#arrdate").datepicker({dateFormat: 'D, dd M yy', yearRange: '+0:+2', minDate: 0, showStatus: true, onSelect: function() {} });
	$("#depdate").datepicker({dateFormat: 'D, dd M yy', yearRange: '+0:+2', showStatus: true, beforeShow: customRange, prevText: '', onSelect: function() {}});
})

function customRange() {
	 return {minDate: $('#arrdate').datepicker('getDate')};
}

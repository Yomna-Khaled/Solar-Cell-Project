function searchciteria(){
	var searchciteria_value = $("#searching" ).val();
	var searchciteria_text = $("#searching option:selected").text();
	var searchciteria = searchciteria_text.split("_")[2];
	$('#searchcriteria').val('')
	if (searchciteria == 'power') {
		$('#searchcriteria').val('power')
	} else{
		$('#searchcriteria').val('serialno')
	};
	var soldornot=$(".target").val();
	if (soldornot == 'sold' ) {
		$('#soldornot').val('notnull');
	} else if (soldornot == 'unsold') {
		$('#soldornot').val('NULL');
	} else{
		$('#soldornot').val('ALL');
	};
}
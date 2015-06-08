function searchciteria(){
	var searchciteria_value = $("#searching" ).val();
	var searchciteria_text = $("#searching option:selected").text();
	var searchciteria = searchciteria_text.split("_")[2];
	$('#searchciteria').val('')
	if (searchciteria == 'power') {
		$('#searchciteria').val('power')
	} else{
		$('#searchciteria').val('serialno')
	};
}
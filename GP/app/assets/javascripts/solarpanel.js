function searchciteria(link){

	$("#Search_by").css("display", "block");
	var searchciteria = link.id
	console.log(searchciteria)
	$('#searchciteria').val('')
	if (searchciteria == 'power') {
		$('#searchciteria').val('power')
	} else{
		$('#searchciteria').val('serialno')
	};
}
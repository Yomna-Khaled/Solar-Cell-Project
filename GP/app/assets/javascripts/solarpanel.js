//buttons
// function searchciteria(link){
// 	$("#Search_by").css("display", "block");
// 	var searchciteria = link.id
// 	console.log(searchciteria)
// 	$('#searchciteria').val('')
// 	if (searchciteria == 'power') {
// 		$('#searchciteria').val('power')
// 	} else{
// 		$('#searchciteria').val('serialno')
// 	};
// }
// drop down list
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
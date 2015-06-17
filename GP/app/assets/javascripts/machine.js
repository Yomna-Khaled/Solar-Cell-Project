//for adding new quantity machine
function showmachineform () {
	$("#addnewmachine").css("display", "block");
	$("#machinelink").css("display", "none");
}

function machineajax () {

	$("#addnewmachine").css("display", "none");
	$("#machinelink").css("display", "block");
	var machinename = $("#machinename").val();
	var machineserialno = $("#machineserialno").val();
	if (machinename!="" && machineserialno!="") {
    $.ajax({
        method: "POST",
        url: '/machinecreate',
		dataType: "JSON",
		data: { 'machinename': machinename,'machineserialno': machineserialno},
		complete: function(data)
		{	
			var machineid = JSON.parse(data.responseText).id
			if (machineid != null) {
			$('#spare_part_machine_id')
	        .append($("<option></option>")
	        .attr("value",machineid)
	        .text(machinename)); 
	        $("#machinename").val("");
	        $("#machineserialno").val("");
	        }else{
	        	var errors = JSON.parse(data.responseText)
				$('#modal-body').text('Machine '+errors[0]);
				$('#basicModal').modal('toggle');
	        }

		}
	});
	}
	else{
		if (machinename == "") {
			$('#modal-body').text('To Add New machine You have to Enter machine Name');;
		} else{
			$('#modal-body').text('To Add New machine You have to Enter machine Serial No');
		};
		$('#basicModal').modal('toggle')
	}
}
function canceladdmachine(){
	$("#addnewmachine").css("display", "none");
	$("#machinelink").css("display", "block");	
}
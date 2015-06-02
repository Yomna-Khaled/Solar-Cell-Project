//for adding new quantity machine
function showmachineform () {
	$("#addnewmachine").css("display", "block");
	$("#machinelink").css("display", "none");
}

function machineajax () {

	$("#addnewmachine").css("display", "none");
	$("#machinelink").css("display", "block");
	var machinename = $("#machinename").val();
	if (machinename!="") {
    $.ajax({
        method: "POST",
        url: '/machinecreate',
		dataType: "JSON",
		data: { 'machinename': machinename},
		complete: function(data)
		{	
			var machineid = JSON.parse(data.responseText).id
			if (machineid != null) {
			$('#spare_part_machine_id')
	        .append($("<option></option>")
	        .attr("value",machineid)
	        .text(machinename)); 
	        $("#machinename").val("");
	        }else{
	        	alert("This Machnie already Exists");
	        }

		}
	});
	}
	else{
		alert("To Add New machine You have to Enter machine Name");
	}
}
function canceladdmachine(){
	$("#addnewmachine").css("display", "none");
	$("#machinelink").css("display", "block");	
}
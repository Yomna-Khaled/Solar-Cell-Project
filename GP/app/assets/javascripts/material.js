function checkproperty (value) {
	var checkBox = document.getElementById(value.id);
	  if(value.checked){
	    var td_for_value = document.getElementById("value_"+value.id);
	    td_for_value.style.display = "block";
	    $('#'+value.id+"_value").attr("required", "true");
	  }else{
	  	$("#"+value.id+"_value").removeAttr("required");
	    var td_for_value = document.getElementById("value_"+value.id);
	    td_for_value.style.display = "none";
	    //to get value of the property from text field
	    td_for_value.childNodes[3].value = "";
	  }
}

function propertyvalue (value) {
	// var property_value = value.childNodes[3].value;
	var value_id = value.id;
	var property_id = value_id.split("_")[1]; 
	var property_value = document.getElementById(property_id+"_value").value;
	if (property_value == "") {
		$('#modal-body').text('Enter Property Value');
		$('#basicModal').modal('toggle');
		document.getElementById(property_id).checked= false;
		document.getElementById(value_id).style.display= "none";
	};
	var checkproperty = document.getElementById(property_id);
	var propertyname = checkproperty.value;
	propertyname = propertyname+":"+property_value;
	var arr = propertyname.split(":");
	var len = arr.length;
	propertyname = arr[0];
	checkproperty.value = propertyname+":"+arr[len-1];
}

//for adding new vendor
function showvendorform () {
	$("#addnewvendor").css("display", "block");
	$("#vendorlink").css("display", "none");
}

function vendorajax () {
	$("#addnewvendor").css("display", "none");
	$("#vendorlink").css("display", "block");
	var vendorname = $("#vendorname").val();
	var vendoremail = $("#vendoremail").val();
	if (vendorname!=""&&vendoremail!="") {
	var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	if (re.test(vendoremail)) {
    $.ajax({
        method: "POST",
        url: '/materialvendorcreate',
		dataType: "JSON",
		data: { 'vendorname': vendorname ,'vendoremail': vendoremail},
		complete: function(data)
		{	
			var vendorid = JSON.parse(data.responseText).id
			$('#vendor')
	        .append($("<option></option>")
	        .attr("value",vendorid)
	        .text(vendorname)); 
	        $("#vendorname").val("");
	        $("#vendoremail").val("");
		}
	});
	}
	else{
		$('#modal-body').text('To Add New Vendor You have to Enter valid Vendor Email');
		$('#basicModal').modal('toggle');
	}
}
	else{
		if (vendorname=="") {
			$('#modal-body').text('To Add New Vendor You have to Enter Vendor Name');
			$('#basicModal').modal('toggle');
		} else{
			$('#modal-body').text('To Add New Vendor You have to Enter Vendor Email');
			$('#basicModal').modal('toggle');
		};
	}
}
function canceladdvendor(){
	$("#addnewvendor").css("display", "none");
	$("#vendorlink").css("display", "block");	
}

//for adding new quantity unit
function showunitform () {
	$("#addnewunit").css("display", "block");
	$("#unitlink").css("display", "none");
}

function unitajax () {


	$("#addnewunit").css("display", "none");
	$("#unitlink").css("display", "block");
	var unitname = $("#unitname").val();
	console.log(unitname);
	if (unitname!="") {
    $.ajax({
        method: "POST",
        url: '/quantities',
		dataType: "JSON",
		data: { 'unitname': unitname},
		complete: function(data)
		{	
			var unitid = JSON.parse(data.responseText).id
			$('#material_quantity_id')
	        .append($("<option></option>")
	        .attr("value",unitid)
	        .text(unitname)); 
	        $("#unitname").val("");
		}
	});
	}
	else{
		$('#modal-body').text('To Add New Unit You have to Enter Unit Name');
		$('#basicModal').modal('toggle');
	}
}
function canceladdunit(){
	$("#addnewunit").css("display", "none");
	$("#unitlink").css("display", "block");	
}

//for adding new property
function showpropertyform () {
	$("#addnewproperty").css("display", "block");
	$("#propertylink").css("display", "none");
}

function propertyajax () {

	$("#addnewproperty").css("display", "none");
	$("#propertylink").css("display", "block");	
	var propertyname = $("#propertyname").val();
	if (propertyname!="") {
    $.ajax({
        method: "POST",
        url: '/properties',
		dataType: "JSON",
		data: { 'propertyname': propertyname},
		complete: function(data)
		{	
			var propertyid = JSON.parse(data.responseText).id
			$('#allproperties').
			append('<tr><td><input type="checkbox" id="'+propertyid+
			'" name="propertycheck[]" onchange="checkproperty(this)" value='+propertyid+'/>'
			+propertyname+'</td><td id="value_'+propertyid+
			'" style="display:none" onkeyup="propertyvalue(this)"><h3 style="margin-left:100px;">value</h3><input type="text" style="width:100px;margin-left:100px;" id="'+propertyid+'_value" ></td></tr>');
			$("#propertyname").val("");
		}
	});
	}
	else{
		$('#modal-body').text('To Add New Property You have to Enter Property Name');
		$('#basicModal').modal('toggle');
	}
}
function canceladdproperty(){
	$("#addnewproperty").css("display", "none");
	$("#propertylink").css("display", "block");	
}

function showvendorhistory () {
	var button_text = $('#showvendorhistory').text();
	console.log(button_text);
	
	if (button_text == "Show History") {
		$('#showvendorhistory').text("Hide History");
	} else{
		$('#showvendorhistory').text("Show History");
	};
	$('#historytable').toggle();
}
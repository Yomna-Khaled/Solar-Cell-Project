function checkproperty (value) {
	var checkBox = document.getElementById(value.id);
	  if(value.checked){
	    var td_for_value = document.getElementById("value_"+value.id);
	    td_for_value.style.display = "block";
	  }else{
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
		alert("Enter Property Value ");
		console.log(document.getElementById(property_id));
		document.getElementById(property_id).checked= false;
		document.getElementById(value_id).style.display= "none";
	};
	var checkproperty = document.getElementById(property_id);
	var propertyname = checkproperty.value;
	propertyname = propertyname+":"+property_value;
	var arr = propertyname.split(":");
	var len = arr.length;
	propertyname = arr[0];
	console.log(arr[len-1])
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
		alert("To Add New Vendor You have to Enter valid Vendor Email");
	}
}
	else{
		if (vendorname=="") {
			alert("To Add New Vendor You have to Enter Vendor Name");
		} else{
			alert("To Add New Vendor You have to Enter Vendor Email");
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
		alert("To Add New Unit You have to Enter Unit Name");
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
			'" style="display:none" onkeyup="propertyvalue(this)"><label style="margin-left:200px;">value</label><input type="text" id="'+propertyid+'_value" ></td></tr>');
		}
	});
	}
	else{
		alert("To Add New Property You have to Enter Property Name");
	}
}
function canceladdproperty(){
	$("#addnewproperty").css("display", "none");
	$("#propertylink").css("display", "block");	
}


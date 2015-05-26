function getquantityid() {
	var selected_element = document.getElementById("quantity");
	var quantity_id = selected_element.options[selected_element.selectedIndex].value;
	var quantity_id_selected = document.getElementById('quantity_id_selected');
	quantity_id_selected.value = quantity_id;
}

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
	var property_value = value.childNodes[3].value;
	var value_id = value.id;
	var property_id = value_id.split("_")[1]; 
	var checkproperty = document.getElementById(property_id);
	var propertyname = checkproperty.value;
	propertyname = propertyname+":"+property_value;
	var arr = propertyname.split(":");
	var len = arr.length;
	propertyname = arr[0];
	checkproperty.value = propertyname+":"+arr[len-1];
}

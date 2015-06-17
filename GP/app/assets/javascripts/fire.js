$(".fire").click(function(){
  var id =this.id;
  $.ajax({
      type: "POST",
      url: "/employees/fire",
      dataType: "JSON",
      data: { 'id':this.id},
      complete: function(data)
      {
        $("#"+id).html("Not Available");
        document.getElementById(id+"e").removeAttribute('href');    
      }
    });
});
function searchemp(){
  console.log($("#search").val());
  var type=$("#search").val();
   $.ajax({
      type: "POST",
      url: "/employees/search",
      dataType: "JSON",
      data: { 'type':type},
      complete: function(data)
      {
         $("#emp").html(data.responseText);
        
      }
    });

}
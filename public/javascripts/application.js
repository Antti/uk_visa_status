// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

(
  function($){
  }
)(jQuery);

UKVisa = {
  update_status: function(id){
    $("tr[data-id="+id+"] td.visa_status").append("<img src='/images/loading-spinner.gif' alt='spinner' />");
    $.get('/visa_applications/'+id+'/update_status',function(data){
      visa_application = data.visa_application;
      $("tr[data-id="+id+"] td.visa_status").text(visa_application.status).effect("highlight");
    });
  }
}

$().ready(function(){
  $("a.update_visa_status").click(function(){
    UKVisa.update_status($(this).parents("tr").attr("data-id"));
    return false;
  })
})
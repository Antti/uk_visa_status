// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

(
  function($){
  }
)(jQuery);

Visa = {
  update_status: function(id){
    $("tr[data-id="+id+"] td.visa_status").append("<img src='/images/loading-spinner.gif' alt='spinner' />");
    $.get($("tr[data-id="+id+"] a.update_visa_status").attr("href"),function(data){
      visa_application = data;
      $("tr[data-id="+id+"] td.visa_status").text(visa_application.status+"("+visa_application.updated_at+")").effect("highlight");
    });
  }
}

$().ready(function(){
  $("a.update_visa_status").click(function(){
    Visa.update_status($(this).parents("tr").attr("data-id"));
    return false;
  })
})
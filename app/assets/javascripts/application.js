//= require jquery
//= require jquery_ujs
(
  function($){
  }
)(jQuery);

Visa = (function(){
  return {
    update_status: function(id){
      $("tr[data-id="+id+"] td.visa_status").append("<img class='spinner' src='/assets/loading-spinner.gif' alt='spinner' />");
      $.get($("tr[data-id="+id+"] a.update_visa_status").attr("href"),function(visa_application){
        $("tr[data-id="+id+"] span.status").text(visa_application.status);
        $("tr[data-id="+id+"] span.notes").text("Updated at "+visa_application.updated_at)
        $("tr[data-id="+id+"] td.visa_status").find('img.spinner').remove();
      });
    }
  }
})();


$().ready(function(){
  $("a.update_visa_status").click(function(){
    Visa.update_status($(this).parents("tr").attr("data-id"));
    return false;
  });
});
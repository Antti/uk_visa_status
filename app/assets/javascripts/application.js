//= require jquery
//= require jquery_ujs
(
  function($){
  }
)(jQuery);

Visa = (function(){
  return {
    init: function(){
      $("a.update_visa_status").click(function(){
        Visa.update_status($(this).parents("tr").attr("data-id"));
        return false;
      });
    },
    update_status: function(id){
      var row = $("tr[data-id="+id+"]");
      row.find("td.visa_status").append("<img class='spinner' src='/assets/loading-spinner.gif' alt='spinner' />");
      $.get(row.find("a.update_visa_status").attr("href"),function(visa_application){
        row.find("span.status").text(visa_application.status_text);
        row.find("span.notes").text("Updated at "+visa_application.updated_at)
        row.find("td.visa_status").find('img.spinner').remove();
      });
    }
  }
})();

$().ready(function(){
  Visa.init();
});
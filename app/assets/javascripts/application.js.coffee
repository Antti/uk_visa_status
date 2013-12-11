//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

(($) ->
) jQuery
Visa = (->
  init: ->
    $("a.update_visa_status").click ->
      Visa.update_status $(this).parents("tr").attr("data-id")
      false

  update_status: (id) ->
    row = $("tr[data-id=#{id}]")
    row.find("td.visa_status").append "<img class='spinner' src='/assets/loading-spinner.gif' alt='spinner' />"
    $.get row.find("a.update_visa_status").attr("href"), (visa_application) ->
      row.find(".status").text visa_application.status_text
      row.find(".notes").text "Updated at " + visa_application.updated_at
      row.find("td.visa_status").find("img.spinner").remove()

)()
$().ready ->
  Visa.init()

(($) ->
  $.fn.highlight = ->
    $(this).css
      color: "red"
      background: "yellow"

    $(this).fadeIn()
) jQuery
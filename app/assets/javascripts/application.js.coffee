//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require ladda/spin
//= require ladda/ladda

(($) ->
) jQuery
Visa = (->
  init: ->
    $(".update_visa_status").click (e)->
      e.preventDefault()
      Visa.update_status $(this).parents("tr").attr("data-id")

  update_status: (id) ->
    row = $("tr[data-id=#{id}]")
    l = Ladda.create row.find(".update_visa_status")[0]
    l.start()
    $.get row.find(".update_visa_status").data("action"), (visa_application) ->
      row.find(".status").text visa_application.status_text
      date = visa_application.updated_at.replace('T', ' ').substr(0,19)
      row.find(".notes").text "Updated at: #{date}"
      l.stop()
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
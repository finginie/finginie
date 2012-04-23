# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  show_hide_input_field = (element) ->
    if $("##{element} input:radio:checked").val() != 'Yes'
      $("##{element}_field").hide()
    $("##{element} input:radio").bind 'click', ->
        if $(this).val() == 'Yes'
          $("##{element}_field").show()
        else
          $("##{element}_field").hide()
  show_hide_input_field("special_goals")
  show_hide_input_field("tax_saving_investment")

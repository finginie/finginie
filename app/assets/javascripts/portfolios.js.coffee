$ ->
  hide_form = (element) ->
    $(element).hide()
  hide_form("#type_of_investment form")

  $('#type_of_investment').change -> (
    hide_form("#type_of_investment form")
    $("#new_" + $(this).find('option:selected').attr('value')+"_transaction").show()
    if($(this).find('option:selected').attr('value') == "stock")
      $('#stock_transaction_company_code_chzn').width("459px")
      $('#stock_transaction_company_code_chzn .chzn-drop').width("459px")
  )

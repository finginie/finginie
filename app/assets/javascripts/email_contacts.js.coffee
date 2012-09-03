$(document).ready ->
  $("#invitations_list .back").click ->
    $("#invitations_list").hide()
    $("#email_contact").show()

  $("#invitations_list form").bind "ajax:beforeSend", ->
    $("#mail_modal").modal "hide"

  $("#invitations_list form").bind "ajax:success", (xhr, data) ->
    update_message_and_ebola_points(data)

  $("#email_contact form").bind "ajax:beforeSend", (data) ->
    hide_error_msg_and_clear_invited_friends_label()
    $("#email_contact").hide()
    show_ajax_spinner()

  $("#email_contact form").bind "ajax:complete", ->
    hide_ajax_spinner()

  $("#email_contact form").bind "ajax:error", (xhr, data) ->
    $("#email_contact").show()
    show_error_msg(data.status)

  $("#email_contact form").bind "ajax:success", (xhr, data) ->
    $("#invitations_list").show()
    initialize_data_tables(data)
    bind_checkbox_event()

  show_error_msg = (status) ->
    $("#email_contact .alert-error").show()
    switch status
      when 401
        error_msg = 'Username or password are incorrect'
      when 403
        error_msg = 'Email Server type is not supported, please choose one of the following: [:gmail, :hotmail, :yahoo, :plaxo, :aol, :mailru, :gmx, :web_de, :seznam, :onelt, :inbox_lt, :tonline_de]'
      else
        error_msg = "Responded with #{status}, please email us at contact@finginie.com"
    $("#email_contact .alert-error").html(error_msg)

  hide_error_msg_and_clear_invited_friends_label = ->
    $("#email_contact .alert-error").hide()
    $("#invitations_list .invite_frnds").val "Invite 0 Friends"

  update_message_and_ebola_points = (data) ->
    $("#flash_notice").html(data.msg)
    $('#points').html(data.points + ' points')

  hide_ajax_spinner = ->
    $("#spinner").hide()

  show_ajax_spinner = ->
    $("#spinner").show()

  initialize_data_tables = (data) ->
    $("#invitations_list .table").dataTable
      aaData: data["aaData"]
      bScrollInfinite: true
      bScrollCollapse: true
      sScrollY: "200px"
      bSort: false
      bDestroy: true
      bFilter: true
      aoColumns: [null, null, null]

  bind_checkbox_event = ->
    $("#invitations_list .table tr .invite").live "click", ->
      no_of_selected_frnds = $(".invite").filter(":checked").length
      $("#invitations_list .invite_frnds").val "Invite " + no_of_selected_frnds + " Friends"

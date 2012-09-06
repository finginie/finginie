$(document).ready ->
  $("#invitations_list form").bind "ajax:beforeSend", ->
    $("#mail_modal").modal "hide"

  $("#invitations_list form").bind "ajax:success", (xhr, data) ->
    update_message_and_ebola_points(data)

  $("#email_contact form").bind "ajax:beforeSend", (data) ->
    hide_error_msg_and_clear_invited_friends_label()
    show_tab('spinner')

  $("#email_contact form").bind "ajax:error", (xhr, data) ->
    show_tab('email_contact')
    show_error_msg(data.status)

  $("#email_contact form").bind "ajax:success", (xhr, data) ->
    show_tab('invitations_list')
    initialize_data_tables(data)
    bind_checkbox_event()

  $("#check_all").click ->
    checked = if $(this).attr("checked") then true else false
    checkboxes =$('#invitations_list form').find(':checkbox')
    checkboxes.attr('checked', checked)
    update_invitations_label()

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

  show_tab = (id) ->
    $("<a href='##{id}'/>").tab('show')

  hide_error_msg_and_clear_invited_friends_label = ->
    $("#check_all").attr('checked', false)
    $("#email_contact .alert-error").hide()
    $("#invitations_list .invite_frnds").val "Invite 0 Friends"

  update_message_and_ebola_points = (data) ->
    $(".notice").html(data.msg)
    $('#points').html(data.points + ' points')

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
      update_invitations_label()

  update_invitations_label = ->
    no_of_selected_frnds = $(".invite").filter(":checked").length
    $("#invitations_list .invite_frnds").val "Invite " + no_of_selected_frnds + " Friends"

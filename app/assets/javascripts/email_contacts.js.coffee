$(document).ready ->
  $('#back_btn').click ->
    close_modal_dialog('invitations')
    $("#email_contact_modal").modal()

  $('#retrive_contacts').click ->
    $('#email_contacts_form').submit()

  $('#invite_frnds').click ->
    $('#invite_frnds_form').submit()

  $("#invite_frnds_form").bind "ajax:beforeSend", ->
    close_modal_dialog('invitations')
    show_ajax_spinner()

  $("#invite_frnds_form").bind "ajax:success", (xhr, data) ->
    hide_ajax_spinner()
    update_message_and_ebola_points(data)

  $("#email_contacts_form").bind "ajax:beforeSend", (data) ->
    hide_error_msg_and_clear_invited_friends_label()
    close_modal_dialog('email_contact')
    show_ajax_spinner()

  $("#email_contacts_form").bind "ajax:complete", ->
    hide_ajax_spinner()

  $("#email_contacts_form").bind "ajax:error", (xhr, data, status) ->
    $("#email_contact_modal").modal()
    show_error_msg(data)


  $("#email_contacts_form").bind "ajax:success", (xhr, data) ->
    $("#invitations_modal").modal()
    initialize_data_tables(data)
    bind_checkbox_event()

  show_error_msg = (data) ->
    $("#error_msg").show()
    $("#error_msg").html data.responseText

  hide_error_msg_and_clear_invited_friends_label = ->
    $("#error_msg").hide()
    $("#invite_frnds").html "Invite 0 Friends"

  close_modal_dialog = (modal_id) ->
    $("##{modal_id}_modal").modal "hide"

  update_message_and_ebola_points = (data) ->
    $("#flash_notice").html(data.msg)
    $('#points').html(data.points + ' points')

  hide_ajax_spinner = ->
    $("body").removeClass "loading"

  show_ajax_spinner = ->
    $("body").addClass "loading"

  initialize_data_tables = (data) ->
    $("#contacts_list").dataTable
      aaData: data["aaData"]
      bScrollInfinite: true
      bScrollCollapse: true
      sScrollY: "200px"
      bSort: false
      bDestroy: true
      bFilter: true
      aoColumns: [null, null, null]

  bind_checkbox_event = ->
    $("#contacts_list tr .invite").live "click", ->
      no_of_selected_frnds = $(".invite").filter(":checked").length
      $("#invite_frnds").html "Invite " + no_of_selected_frnds + " Friends"

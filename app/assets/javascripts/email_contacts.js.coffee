$(document).ready ->
  $('#retrive_contacts').click ->
    $('#email_contacts_form').submit()

  $('#invite_frnds').click ->
    $('#invite_frnds_form').submit()

  $("#invite_frnds_form").bind "ajax:beforeSend", ->
    $("#invitations_modal").modal "hide"
    $("body").addClass "loading"

  $("#invite_frnds_form").bind "ajax:complete", ->
    $("body").removeClass "loading"

  $("#invite_frnds_form").bind "ajax:success", (xhr, data) ->
    $("#flash_notice").html(data.msg)

  $("#email_contacts_form").bind "ajax:beforeSend", (data) ->
    $("#error_msg").hide()
    $("#count").html "Invite 0 Friends"
    $("#email_contact_modal").modal "hide"
    $("body").addClass "loading"

  $("#email_contacts_form").bind "ajax:complete", ->
    $("body").removeClass "loading"

  $("#email_contacts_form").bind "ajax:error", (xhr, data, status) ->
    $("#email_contact_modal").modal()
    $("#error_msg").show()
    $("#error_msg").html data.responseText

  $("#email_contacts_form").bind "ajax:success", (xhr, data) ->
    initialize_data_tables(data)
    bind_checkbox_event()
    $("#invitations_modal").modal()


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
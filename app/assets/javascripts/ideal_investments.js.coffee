$(document).ready ->
  $("#contacts_form").bind "ajax:beforeSend", (data) ->
    $("#error_msg").hide()
    $("#count").html "Invite 0 Friends"
    $("#mailModal").modal "hide"
    $("body").addClass "loading"

  $("#contacts_form").bind "ajax:complete", ->
    $("body").removeClass "loading"

  $("#contacts_form").bind "ajax:error", (xhr, data, status) ->
    $("#mailModal").modal()
    $("#error_msg").show()
    $("#error_msg").html data.responseText

  $("#contacts_form").bind "ajax:success", (xhr, data) ->
    $("#contacts_list").dataTable
      aaData: data["aaData"]
      bScrollInfinite: true
      bScrollCollapse: true
      sScrollY: "200px"
      bSort: false
      bDestroy: true
      bFilter: true
      aoColumns: [null, null, null]

    $("#contacts_list tr .invite").live "click", ->
      x = $(".invite").filter(":checked").length
      $("#count").html "Invite " + x + " Friends"

    $("#myModal").modal()


$ ->
  fnToDisplayColumn = (elements) ->
    a = []
    $.each elements, (index) ->
      a.push mDataProp: elements[index]
    return a

  fnFormatDataToDisplay = (elements) ->
    (nRow, aData, iDisplayIndex) ->
      $.each elements, (index) ->
        link = "#{elements[index]}_url"
        $("td:eq(#{index})", nRow).html "<a href='#{aData[link]}'>#{aData[elements[index]]}</a>"  if aData[link]

  $('.data_tables').dataTable
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bProcessing: true
    bServerSide: true
    aaSorting: []
    fnRowCallback: fnFormatDataToDisplay($('.data_tables').data('column'))
    sAjaxSource: $('.data_tables').data('source')
    aoColumns: fnToDisplayColumn($('.data_tables').data('column'))

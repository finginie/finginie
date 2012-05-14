$ ->
  $('#scheme_scheme_name').autocomplete
    source: $('#scheme_scheme_name').data('autocomplete-source'),
    select: ( event, ui ) ->
			  window.location = "/mutual_funds/#{ui.item.value}/scheme_summary";

  change = parseFloat($(".day_change").text().trim())
  percentage_change = parseFloat($(".percentage_change").text().trim().slice(1,-2))

  if(change < 0)
    $("body.mutual_funds .day_change").removeClass('green').addClass('red')
  else
    $("body.mutual_funds .day_change").removeClass('red').addClass('green')

  if(percentage_change < 0)
    $("body.mutual_funds .percentage_change").removeClass('green').addClass('red')
  else
    $("body.mutual_funds .percentage_change").removeClass('red').addClass('green')


jQuery ->
  $('#schemes_table').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#schemes_table').data('source')
    oLanguage: { "sSearch": 'Get Funds' }

  $(".dataTables_processing").css('visibility', 'hidden');

  $('#schemes_table').dataTable().bind('filter', ->
      $("#categories_table").css('visibility', 'hidden');
  )

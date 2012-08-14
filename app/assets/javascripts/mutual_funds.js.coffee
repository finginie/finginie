$ ->
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
    sDom: "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#schemes_table').data('source')
    oLanguage: { "sSearch": 'Get Fund NAV' }
    aoColumns: [
      { "mDataProp": "name" },
      { "mDataProp": "class_description" },
      { "mDataProp": "minimum_investment_amount" }
    ]

  $(".dataTables_processing").css('visibility', 'hidden');

  $('#schemes_table').dataTable().bind('filter', ->
      $("#categories_table").css('visibility', 'hidden');
  )

  $('.nav-tabs a:first').tab('show')

  new App.MutualFundGainers({el: $("#top_performers"), data: { limit: 10}})

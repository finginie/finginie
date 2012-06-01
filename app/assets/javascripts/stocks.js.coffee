$ ->

  $('#company_name').autocomplete
    source: ( request, response ) ->
      $.getJSON( $('#company_name').data('autocomplete-source'), { company: { name: request.term } }, response );
    select: ( event, ui ) ->
		    window.location = "/shares/#{ui.item.value}";

  net_change = parseFloat($(".daily_price_change > .net_change").text())
  percentage_change = parseFloat($(".daily_price_change > .percent_change").text().slice(1,-2))
  if net_change < 0.0
    $("body.stocks.show .daily_price_change > .net_change").removeClass('green').addClass('red')
  else
    $("body.stocks.show .daily_price_change > .net_change").removeClass('red').addClass('green')

  if percentage_change < 0.0
    $("body.stocks.show .daily_price_change > .percent_change").removeClass('green').addClass('red')
  else
    $("body.stocks.show .daily_price_change > .percent_change").removeClass('red').addClass('green')

jQuery ->

  $('#stocks_table').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#stocks_table').data('source')
    oLanguage: { "sSearch": 'Get Quotes' }

  $(".dataTables_processing").css('visibility', 'hidden');

  $("div#slider-range").each ->
    $(this).slider({
		  orientation: "horizontal",
		  range: true,
		  min: $(this).data("min-values"),
		  max: $(this).data("max-values"),
		  values: [$(this).data("min-values"), $(this).data("max-values")]
		  slide: ( event, ui ) ->
			  $( "##{$(this).data("min-field")}" ).val( ui.values[ 0 ])
			  $( "##{$(this).data("max-field")}" ).val( ui.values[ 1 ])
		  });

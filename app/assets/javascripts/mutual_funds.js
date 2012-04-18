$(document).ready(function() {
  $(function() {
    return $('#scheme_scheme_name').autocomplete({
      source: $('#scheme_scheme_name').data('autocomplete-source'),
      select: function (event, ui) {
				$(event.target).val(ui.item.label);
				window.location = "/mutual_funds/" + ui.item.value +"/scheme_summary";
				return false;
			}
    });
  });

  function drawColumnChart(container, dataAttrs, title, vAxisTitle) {
    if($("#"+container).attr(dataAttrs) != undefined) {
      var wrapper = new google.visualization.ChartWrapper({
        chartType: 'ColumnChart',
        dataTable: JSON.parse($("#"+container).attr(dataAttrs)),
        options: {
          'title': title,
          'width': 750,
          'height': 400,
          'vAxis': { 'title': vAxisTitle },
          'chartArea': { 'width': '80%' },
          'backgroundColor': { 'strokeWidth':3, 'stroke': '#CE5A5A' },
          'legend': { 'position': 'bottom' },
          'series': [{'color': '#CE5A5A'}, {'color': '#908080'}, {'color': '#fff'}]
          },
        containerId: container
      });
      wrapper.draw();
    }
  }

  function drawPieChart(container, dataAttrs, title) {
    if($("#"+container).attr(dataAttrs) != undefined) {
      var wrapper = new google.visualization.ChartWrapper({
        chartType: 'PieChart',
        dataTable: JSON.parse($("#"+container).attr(dataAttrs)),
        options: {
          'title': title,
          'width': 750,
          'height': 400,
          'chartArea': { 'width': '80%' },
          'backgroundColor': { 'strokeWidth':3, 'stroke': '#CE5A5A' },
          'legend': { 'position': 'right' },
          'series': [{'color': '#CE5A5A'}, {'color': '#908080'}, {'color': '#fff'}],
          'is3D': true
          },
        containerId: container
      });
      wrapper.draw();
    }
  }

  google.setOnLoadCallback(drawColumnChart('mf-comparative-returns-chart', 'data-comparative-returns', 'Comparative Returns', 'Return(%)'));

  google.setOnLoadCallback(drawPieChart('mf-asset-allocation-chart', 'mf-data-asset-allocation', 'Asset Allocation'));

  google.setOnLoadCallback(drawPieChart('mf-sectoral-allocation-chart', 'mf-data-sectoral-allocation', 'Sectoral Allocation'));

  google.setOnLoadCallback(drawPieChart('top-holdings-chart', 'data-percentages', 'Top 10 Holdings Distribution'));

  var change = parseFloat($(".day_change").text().trim())
  var percentage_change = parseFloat($(".percentage_change").text().trim().slice(1,-2))

  if(change < 0){
    $("body.mutual_funds .day_change").removeClass('green').addClass('red')
  }
  else{
    $("body.mutual_funds .day_change").removeClass('red').addClass('green')
  }

  if(percentage_change < 0){
    $("body.mutual_funds .percentage_change").removeClass('green').addClass('red')
  }
  else{
    $("body.mutual_funds .percentage_change").removeClass('red').addClass('green')
  }

});

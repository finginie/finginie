function drawColumnChart(container) {
  if($(container).attr('data-elements') != undefined) {
    var wrapper = new google.visualization.ChartWrapper({
      chartType: 'ColumnChart',
      dataTable: JSON.parse($(container).attr('data-elements')),
      options: {
        'title': $(container).attr('data-title'),
        'width': 750,
        'height': 400,
        'vAxis': { 'title': $(container).attr('data-yAxisTitle') },
        'chartArea': { 'width': '80%' },
        'backgroundColor': { 'strokeWidth':3, 'stroke': '#CE5A5A' },
        'legend': { 'position': $(container).attr('data-legend') || 'none' },
        'series': [{'color': '#CE5A5A'}, {'color': '#3792C2'}, {'color': '#CE5A5A'}]
        },
      containerId: $(container).attr("id")
    });
    wrapper.draw();
  }
}

function drawPieChart(container) {
  if($(container).attr('data-elements') != undefined) {
    var wrapper = new google.visualization.ChartWrapper({
      chartType: 'PieChart',
      dataTable: JSON.parse($(container).attr('data-elements')),
      options: {
        'title': $(container).attr('data-title'),
        'width': 750,
        'height': 400,
        'chartArea': { 'width': '80%' },
        'backgroundColor': { 'strokeWidth':3, 'stroke': '#CE5A5A' },
        'legend': { 'position': $(container).attr('data-legend') || 'right' },
        'is3D': true
        },
      containerId: $(container).attr("id")
    });
    wrapper.draw();
  }
}

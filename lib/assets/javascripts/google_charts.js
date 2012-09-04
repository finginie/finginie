function drawColumnChart(container) {
  if($(container).data('elements') != undefined) {
    var wrapper = new google.visualization.ChartWrapper({
      chartType: 'ColumnChart',
      dataTable: $(container).data('elements'),
      options: {
        'title': $(container).data('title'),
        'width': $(container).parent().width(),
        'height': $(container).parent().width() * 3/5,
        'vAxis': { 'title': $(container).data('yaxistitle') },
        'hAxis': { 'title': $(container).data('xaxistitle') },
        'chartArea': { 'width': '75%' },
        'backgroundColor': { 'strokeWidth':3, 'stroke': '#CE5A5A' },
        'legend': { 'position': $(container).data('legend') || 'none' },
        'series': [{'color': '#CE5A5A'}, {'color': '#3792C2'}, {'color': '#CE5A5A'}]
        },
      containerId: $(container).attr("id")
    });
    wrapper.draw();
  }
}

function drawPieChart(container) {
  if($(container).data('elements') != undefined) {
    var wrapper = new google.visualization.ChartWrapper({
      chartType: 'PieChart',
      dataTable: $(container).data('elements'),
      options: {
        'title': $(container).data('title'),
        'width': $(container).parent().width(),
        'height': $(container).parent().width() * 3/5,
        'chartArea': { 'width': '80%' },
        'backgroundColor': { 'strokeWidth':3, 'stroke': '#CE5A5A' },
        'legend': { 'position': $(container).data('legend') || 'right' },
        'is3D': true
        },
      containerId: $(container).attr("id")
    });
    wrapper.draw();
  }
}

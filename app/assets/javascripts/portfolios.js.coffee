$ ->
  if ($("#portfolio-net-worth-chart").attr("data-portfolio-net-worth-allocation") != undefined)
    new Highcharts.Chart({
      chart: {
        renderTo: 'portfolio-net-worth-chart'
      },
      title: {
        text: 'Portfolio Composition'
      },
      series: [{
        type: 'pie',
        data: JSON.parse($("#portfolio-net-worth-chart").attr("data-portfolio-net-worth-allocation"))
      }],
      legend: {
        labelFormatter: ->  this.name + ': ' + this.y + '%'
      },
      tooltip: {
        formatter: -> '' + this.point.name + ': ' + Math.round(this.y*10) / 10 + '%'
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            formatter: -> '' + this.point.name + ': ' + Math.round(this.y*10) / 10 + '%'
            },
          showInLegend: false
             }
      }
    });

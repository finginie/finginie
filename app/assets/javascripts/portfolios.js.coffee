$ ->
  if ($("#portfolio-total-asset-allocation-chart").attr("data-portfolio-total-asset-allocation") != undefined)
    new Highcharts.Chart({
      chart: {
        renderTo: 'portfolio-total-asset-allocation-chart'
      },
      title: {
        text: 'Portfolio Assets Composition'
      },
      series: [{
        type: 'pie',
        data: JSON.parse($("#portfolio-total-asset-allocation-chart").attr("data-portfolio-total-asset-allocation"))
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

  if ($("#net-worth-chart").attr("data-net-worth") != undefined)
    new Highcharts.Chart({
      chart: {
        renderTo: 'net-worth-chart',
        defaultSeriesType: 'column',
        borderWidth: 2
      },
      title: {
        text: 'Net Worth'
      },
      xAxis: {
        categories: ['Assets', 'Liabilities', 'Net Worth' ]
      },
      yAxis: {
        title: {
          text: 'Amount'
          }
      },
      legend: {
        layout: 'vertical',
        backgroundColor: '#FFFFFF',
        align: 'left',
        verticalAlign: 'top',
        x: 100,
        y: 70,
        floating: true,
        shadow: true
      },
      tooltip: {
              formatter: -> '' + this.series.name + ': ' + this.y + ''
      },
      series: [{
        data: JSON.parse($("#net-worth-chart").attr("data-net-worth"))
        }
      ]
    });

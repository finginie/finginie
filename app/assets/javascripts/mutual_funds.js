$(document).ready(function() {
  if ($("#mf-asset-allocation-chart").attr("mf-data-asset-allocation") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'mf-asset-allocation-chart'
      },
      title: {
        text: 'Asset Allocation'
      },
      series: [{
        type: 'pie',
        data: JSON.parse($("#mf-asset-allocation-chart").attr("mf-data-asset-allocation"))
      }],
      legend: {
        labelFormatter: function() {
          return this.name + ': ' + this.y + '%';
        }
      },
      tooltip: {
        formatter: function() {
          return '' + this.point.name +': '+ (Math.round(this.y*10) / 10) + '%';
          }
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            formatter: function() {
            return '' + this.point.name +': '+ (Math.round(this.y*10) / 10) + '%';
            }
          },
          showInLegend: true
        }
      }
    });
  };

  if ($("#top-holdings-chart").attr("data-percentages") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'top-holdings-chart'
      },
      title: {
        text: 'Top 10 Holdings Distribution'
      },
      series: [{
        type: 'pie',
        data: JSON.parse($("#top-holdings-chart").attr("data-percentages"))
      }],
      legend: {
        labelFormatter: function() {
          return this.name + ': ' + this.y + '%';
        }
      },
      tooltip: {
        formatter: function() {
          return '' + this.point.name +': '+ (Math.round(this.y*10) / 10) + '%';
          }
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            formatter: function() {
            return '' + this.point.name +': '+ (Math.round(this.y*10) / 10) + '%';
            }
          },
          showInLegend: false
        }
      }
    });
  };

  if ($("#mf-comparative-returns-chart").attr("data-scheme-returns") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'mf-comparative-returns-chart',
        defaultSeriesType: 'column',
      },
      title: {
        text: 'Comparative Returns'
      },
      xAxis: {
        categories: ['1 week', '1 month', '3 months', '6 months', '9 months', '1 year', '2 years', '3 years']
      },
      legend: {
         layout: 'vertical',
         align: 'left',
         verticalAlign: 'top',
         floating: true,
         shadow: true
      },
      tooltip: {
        formatter: function() {
          return '' + this.x + ': ' + this.y + '';
          }
      },
      plotOptions: {
        series: {
          colorByPoint: true,
          showInLegend: false
                },
        column: {
          pointPadding: 0.2
                }
      },
      series: [{
        name: 'Scheme Returns',
        data: JSON.parse($("#mf-comparative-returns-chart").attr("data-scheme-returns"))
        },
        {
        name: 'Category Returns',
        data: JSON.parse($("#mf-comparative-returns-chart").attr("data-category-returns"))
        }
      ]
    });
  };

});

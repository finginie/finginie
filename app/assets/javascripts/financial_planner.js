// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {
  if ($("#asset-allocation-chart").attr("data-asset-allocation") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'asset-allocation-chart'
      },
      title: {
        text: 'Suggested Asset Allocation'
      },
      series: [{
        type: 'pie',
        data: JSON.parse($("#asset-allocation-chart").attr("data-asset-allocation"))
      }],
      legend: {
        labelFormatter: function() {
          return this.name + ':  ' + this.y + '%';
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
            enabled: false
                      },
          showInLegend: true
             }
      }
    });
  };

  if ($("#emotional-risk-appetite").attr("emotional-risk-appetite-data") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'emotional-risk-appetite',
        defaultSeriesType: 'column',
        inverted: true
      },
      title: {
        text: 'Emotional Risk Appetite'
      },
      xAxis: {
        categories: ['Average','Your Score','Maximum']
      },
      yAxis: {
        tickInterval: 1
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
          groupPadding : 0.1,
          pointPadding: 0
                }
      },
      credits: {
        enabled: false
      },
      series: [{
        data:  JSON.parse($("#emotional-risk-appetite").attr("emotional-risk-appetite-data"))
      }]
    });
  };

  if ($("#financial-risk-appetite").attr("financial-risk-appetite-data") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'financial-risk-appetite',
        defaultSeriesType: 'column',
        inverted: true
      },
      title: {
        text: 'Financial Risk Appetite'
      },
      xAxis: {
        categories: ['Average','Your Score','Maximum']
      },
      yAxis: {
        tickInterval: 1
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
          groupPadding : 0.1,
          pointPadding: 0
                }
      },
      credits: {
        enabled: false
      },
      series: [{
        data:  JSON.parse($("#financial-risk-appetite").attr("financial-risk-appetite-data"))
      }]
    });
  };
});

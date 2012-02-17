$(document).ready(function() {

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

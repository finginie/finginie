$(document).ready(function() {
  if ($("#share-holding-chart").attr("data-share-holding") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'share-holding-chart',
        borderColor: '#CE5A5A',
        borderWidth: 2
      },
      title: {
        text: 'Share Holding Pattern',
        style: {
            color: '#000',
            fontWeight: 'bold',
	    fontSize: '16px'
        }
      },
      series: [{
        type: 'pie',
        data: JSON.parse($("#share-holding-chart").attr("data-share-holding"))
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
});

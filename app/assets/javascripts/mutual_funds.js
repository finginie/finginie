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
  if ($("#mf-sectoral-allocation-chart").attr("mf-data-sectoral-allocation") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'mf-sectoral-allocation-chart',
        width: 750,
        borderColor: '#CE5A5A',
        borderWidth: 2
      },
      title: {
        text: 'Sectoral Allocation',
        style: {
          color: '#000',
          fontWeight: 'bold',
          fontSize: '16px'
        }
      },
      series: [{
        type: 'pie',
        data: JSON.parse($("#mf-sectoral-allocation-chart").attr("mf-data-sectoral-allocation"))
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

  if ($("#mf-asset-allocation-chart").attr("mf-data-asset-allocation") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'mf-asset-allocation-chart',
        width: 750,
        borderColor: '#CE5A5A',
        borderWidth: 2
      },
      title: {
        text: 'Asset Allocation',
        style: {
          color: '#000',
          fontWeight: 'bold',
          fontSize: '16px'
        }
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
          showInLegend: false
        }
      }
    });
  };

  if ($("#top-holdings-chart").attr("data-percentages") != undefined) {
    new Highcharts.Chart({
      chart: {
        renderTo: 'top-holdings-chart',
        width: 750,
        borderColor: '#CE5A5A',
        borderWidth: 2
      },
      title: {
        text: 'Top 10 Holdings Distribution',
        style: {
          color: '#000',
          fontWeight: 'bold',
          fontSize: '16px'
        }
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
        width: 750,
        borderColor: '#CE5A5A',
        borderWidth: 2
      },
      title: {
        text: 'Comparative Returns',
        style: {
          color: '#000',
          fontWeight: 'bold',
          fontSize: '16px'
        }
      },
      xAxis: {
        categories: ['1 week', '1 month', '3 months', '6 months', '9 months', '1 year', '2 years', '3 years']
      },
      yAxis: {
        title: {
          text: 'Percentage Returns'
          }
      },
      legend: {
        layout: 'vertical',
        backgroundColor: '#FFFFFF',
        align: 'left',
        verticalAlign: 'top',
        x: 200,
        y: 70,
        floating: true,
        shadow: true
		  },
      tooltip: {
        formatter: function() {
          return '' + this.series.name + ': ' + this.y + '';
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

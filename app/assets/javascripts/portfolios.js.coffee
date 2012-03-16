$ ->
  pie_chart = (element, data, title) ->
    if ($("##{element}").attr("#{data}") != undefined)
      new Highcharts.Chart({
        chart: {
          renderTo: element,
          borderColor: '#CE5A5A',
          borderWidth: 2,
          width: 950
        },
        title: {
          text: title,
          style: {
            color: '#000',
            fontWeight: 'bold',
            fontSize: '16px'
          }
        },
        series: [{
          type: 'pie',
          data: JSON.parse($("#"+element).attr(data))
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

  bar_chart = (element, data, title, categories, y_axis_title) ->
    if ($("##{element}").attr(data) != undefined)
      new Highcharts.Chart({
        chart: {
          renderTo: element,
          defaultSeriesType: 'column',
          borderWidth: 2
        },
        title: {
          text: title
        },
        xAxis: {
          categories: categories
        },
        yAxis: {
          title: {
            text: y_axis_title
            }
        },
        plotOptions: {
          column: {
            pointWidth: 50
            }
        },
        tooltip: {
                formatter: -> '' + this.x + ': ' + this.y + ''
        },
        series: [{
          data: JSON.parse($("##{element}").attr(data))
          showInLegend: false
          }
        ]
      });
  pie_chart('portfolio-total-asset-allocation-chart', 'data-portfolio-total-asset-allocation', 'Portfolio Assets Composition')
  pie_chart('stock-sectoral-allocation-chart', 'data-stocks-sectoral-asset-allocation', 'Sector Wise Stocks Allocation')
  pie_chart('mutual-fund-category-wise-allocation-chart', 'data-mutual-fund-category-wise-asset-allocation', 'Category Wise Mutual Funds Allocation')

  bar_chart('net-worth-chart','data-net-worth','Net Worth',['Assets', 'Liabilities', 'Net Worth' ],'Amount(Rupees)')

  if $("#stocks-profit-or-loss-chart").attr("data-categories") != undefined
    bar_chart('stocks-profit-or-loss-chart','data-stocks-profit-or-loss','Realized Profit/Loss on Stocks', JSON.parse($("#stocks-profit-or-loss-chart").attr("data-categories")), 'Amount(Rupees)')

  if $("#mutual-fund-profit-or-loss-chart").attr("data-categories") != undefined
    bar_chart('mutual-fund-profit-or-loss-chart','data-mutual-fund-profit-or-loss','Realized Profit/Loss on Mutual Funds', JSON.parse($("#mutual-fund-profit-or-loss-chart").attr("data-categories")), 'Amount(Rupees)')

  if $("#fixed-deposits-chart").attr("data-categories") != undefined
    bar_chart('fixed-deposits-chart','data-fixed-deposits','Your Fixed Deposits', JSON.parse($("#fixed-deposits-chart").attr("data-categories")), 'Amount Invested')

  if $("#accumulated-profits-chart").attr("data-categories") != undefined
    bar_chart('accumulated-profits-chart','data-accumulated-profits','Your Top 5 Accumulated Profits', JSON.parse($("#accumulated-profits-chart").attr("data-categories")), 'Amount(Rupees)')

  if $("#accumulated-losses-chart").attr("data-categories") != undefined
    bar_chart('accumulated-losses-chart','data-accumulated-losses','Your Top 5 Accumulated Losses', JSON.parse($("#accumulated-losses-chart").attr("data-categories")), 'Amount(Rupees)')

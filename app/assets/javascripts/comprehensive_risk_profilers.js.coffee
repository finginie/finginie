# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  show_hide_input_field = (element) ->
    if $("##{element} input:radio:checked").val() != 'Yes'
      $("##{element}_field").hide()
    $("##{element} input:radio").bind 'click', ->
        if $(this).val() == 'Yes'
          $("##{element}_field").show()
        else
          $("##{element}_field").hide()
  show_hide_input_field("special_goals")
  show_hide_input_field("tax_saving_investment")

$ ->
  if ($("#asset-allocation-chart").attr("data-asset-allocation") != undefined)
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
        labelFormatter: ->  this.name + ': ' + this.y + '%'
      },
      tooltip: {
        formatter: -> '' + this.point.name + ': '+ Math.round(this.y*10) / 10 + '%'
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

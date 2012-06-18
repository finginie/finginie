# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http:#example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require environment
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require dataTables/jquery.dataTables
#
#= require html5
#= require personal_financial_tools
#= require chosen.jquery.min
#= require google_charts
#
#= require disqus
#= require twitter
#= require facebook
#= require analytics
#
#= require_self
#= require_tree .

google.load('visualization', '1');

$ ->

  $("div.chart").each ->
    if $(this).attr("data-chartType") is "Column"
      google.setOnLoadCallback drawColumnChart(this)
    else
      google.setOnLoadCallback drawPieChart(this)

  $("div.tabs").each ->
    $(this).tabs();

  $('[data-autocomplete-source]').each ->
    $(this).autocomplete
      source: $(this).data('autocomplete-source'),
      if !$(this).data('no-redirect')
        select: ( event, ui ) =>
            window.location = $(this).data('autocomplete-source') + "/"+ ui.item.id;


# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http:#example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#
#= require html5
#= require personal_financial_tools
#= require highcharts
#= require chosen.jquery.min
#
#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#
#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#
#= require_tree .

Exceptional.setKey('82363b82eb75251b81ffdd8246eedc066481f756')

window.Finginie =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

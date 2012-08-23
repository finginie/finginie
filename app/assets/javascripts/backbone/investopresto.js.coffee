#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Finginie =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  @nifty = new Finginie.Models.NseScrip
    id: 'NSE Index'
    name: 'Nifty'
  @gold = new Finginie.Models.NseScrip
    id: 'GOLDBEES'
    name: 'Gold (per gm.)'
  @sensex = new Finginie.Models.BseScrip
    id: 'Sensex'
    name: 'Sensex'
  @update_indices = =>
    @sensex.fetch()
    @nifty.fetch()
    @gold.fetch()

  @update_indices()
  @indices_view = new Finginie.Views.Indices.IndicesView
    indices: [@nifty, @sensex, @gold]
  $('#indices').html(@indices_view.render().el)

  setInterval(@update_indices, 60 * 1000)


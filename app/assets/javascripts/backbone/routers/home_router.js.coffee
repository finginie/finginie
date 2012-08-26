class Finginie.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @top_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @top_mutual_funds.fetch
      data:
        desc: 'percentage_change'
        limit: 5

  routes:
    ""    : "index"

  index: ->
    @view = new Finginie.Views.MutualFunds.IndexView(mutual_funds: @top_mutual_funds)
    $("#top_mutual_funds").html(@view.render().el)

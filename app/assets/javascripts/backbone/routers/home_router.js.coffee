class Finginie.Routers.HomeRouter extends Backbone.Router
  initialize: (options) ->
    @top_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @top_mutual_funds.fetch
      data:
        desc: 'percentage_change'
        limit: 5
    @lowest_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @lowest_mutual_funds.fetch
      data:
        asc: 'percentage_change'
        limit: 5
    @biggest_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @biggest_mutual_funds.fetch
      data:
        desc: 'size'
        limit: 5

  routes:
    ""    : "index"

  index: ->
    @top_mutual_funds_view = new Finginie.Views.MutualFunds.TopMutualFundsView(mutual_funds: @top_mutual_funds)
    $("#top_mutual_funds").html(@top_mutual_funds_view.render().el)
    @lowest_mutual_funds_view = new Finginie.Views.MutualFunds.TopMutualFundsView(mutual_funds: @lowest_mutual_funds)
    $("#lowest_mutual_funds").html(@lowest_mutual_funds_view.render().el)
    @biggest_mutual_funds_view = new Finginie.Views.MutualFunds.BigMutualFundsView(mutual_funds: @biggest_mutual_funds)
    $("#biggest_mutual_funds").html(@biggest_mutual_funds_view.render().el)

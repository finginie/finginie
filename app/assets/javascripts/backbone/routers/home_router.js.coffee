class Finginie.Routers.HomeRouter extends Backbone.Router
  routes:
    ""    : "index"

  index: ->
    @render_top_mutual_funds()
    @render_lowest_mutual_funds()
    @render_biggest_mutual_funds()
    @render_sectoral_indices('Nse')
    @render_sectoral_indices('Bse')

  render_top_mutual_funds: ->
    @top_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @top_mutual_funds.fetch
      data:
        desc: 'percentage_change'
        limit: 5
    @top_mutual_funds_view = new Finginie.Views.MutualFunds.TopMutualFundsView(mutual_funds: @top_mutual_funds)
    $("#top_mutual_funds").html(@top_mutual_funds_view.render().el)

  render_lowest_mutual_funds: ->
    @lowest_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @lowest_mutual_funds.fetch
      data:
        asc: 'percentage_change'
        limit: 5
    @lowest_mutual_funds_view = new Finginie.Views.MutualFunds.TopMutualFundsView(mutual_funds: @lowest_mutual_funds)
    $("#lowest_mutual_funds").html(@lowest_mutual_funds_view.render().el)

  render_biggest_mutual_funds: ->
    @biggest_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @biggest_mutual_funds.fetch
      data:
        desc: 'size'
        limit: 5
    @biggest_mutual_funds_view = new Finginie.Views.MutualFunds.BigMutualFundsView(mutual_funds: @biggest_mutual_funds)
    $("#biggest_mutual_funds").html(@biggest_mutual_funds_view.render().el)

  render_sectoral_indices: (exchange)->
    sectoral_indices = new Finginie.Collections.ScripsCollection()
    sectoral_indices.fetch
      data:
        exchange: exchange
        sectoral_indices: 'all'
    sectoral_indices_view = new Finginie.Views.SectoralIndices.IndicesView(indices: sectoral_indices)
    $("##{exchange}_sectoral_indices").html(sectoral_indices_view.render().el)

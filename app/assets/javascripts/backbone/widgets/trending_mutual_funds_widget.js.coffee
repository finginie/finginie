class Finginie.Widgets.TrendingMutualFundsWidget
  constructor: (opts={trend: 'desc'})->
    @mutual_funds = new Finginie.Collections.MutualFundsCollection()
    data =
      limit: 5
    data[opts.trend] = 'percentage_change'
    @mutual_funds.fetch
      data: data

  render: (target)=>
    @view = new Finginie.Views.MutualFunds.TrendingMutualFundsView(mutual_funds: @mutual_funds)
    $(target).html(@view.render().el)

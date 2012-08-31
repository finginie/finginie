class Finginie.Widgets.TrendingSharesWidget
  constructor: (opts={})->
    _.extend opts,
      exchange: 'Nse'
      trend: 'gainers'

    data = exchange: opts.exchange
    data[opts.trend]= 5

    @shares = new Finginie.Collections.ScripsCollection()
    @shares.fetch
      data: data

  render: (target)=>
    @view = new Finginie.Views.Shares.TrendingSharesView(shares: @shares)
    $(target).html(@view.render().el)

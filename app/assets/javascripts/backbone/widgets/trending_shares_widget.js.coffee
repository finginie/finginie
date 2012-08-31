class Finginie.Widgets.TrendingSharesWidget
  constructor: (opts={})->
    _.defaults opts,
      exchange: 'Nse'
      trend: 'gainers'

    data = exchange: opts.exchange
    data["top_#{opts.trend}"]= 5

    @shares = new Finginie.Collections.ScripsCollection()
    @shares.fetch
      data: data

  render: (target)=>
    @view = new Finginie.Views.Scrips.TrendingSharesView(scrips: @shares)
    $(target).html(@view.render().el)

class Finginie.Widgets.MostActiveSharesWidget
  constructor: (opts={})->
    _.extend opts,
      exchange: 'Nse'

    @shares = new Finginie.Collections.ScripsCollection()
    @shares.fetch
      data:
        exchange: exchange
        most_active: 5

  render: (target)=>
    @view = new Finginie.Views.Shares.MostActiveSharesView(shares: @shares)
    $(target).html(@view.render().el)

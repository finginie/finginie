class Finginie.Widgets.MostActiveSharesWidget
  constructor: (opts={})->
    _.defaults opts,
      exchange: 'Nse'

    @shares = new Finginie.Collections.ScripsCollection()
    @shares.fetch
      data:
        exchange: opts.exchange
        most_active: 5

  render: (target)=>
    @view = new Finginie.Views.Scrips.MostActiveSharesView(scrips: @shares)
    $(target).html(@view.render().el)

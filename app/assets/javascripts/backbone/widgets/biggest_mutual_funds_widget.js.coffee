class Finginie.Widgets.BiggestMutualFundsWidget
  constructor: ->
    @mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @mutual_funds.fetch
      data:
        limit: 5
        desc: 'size'

  render: (target)=>
    @view = new Finginie.Views.MutualFunds.BigMutualFundsView(mutual_funds: @mutual_funds)
    $(target).html(@view.render().el)

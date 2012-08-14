$ = jQuery.sub()
MutualFundGainer = App.MutualFundGainer
BiggestMutualFund = App.BiggestMutualFund
MutualFundLoser = App.MutualFundLoser

class App.MutualFundGainers extends Spine.Controller

  constructor: (params)->
    super
    MutualFundGainer.bind 'refresh change', @render
    MutualFundGainer.fetch(params)

  render: =>
    mutual_funds = MutualFundGainer.all()[0].aaData
    @html @view('mutual_fund_gainers/index')(mutual_funds: mutual_funds)

class App.BiggestMutualFunds extends Spine.Controller

  constructor: ->
    super
    BiggestMutualFund.bind 'refresh change', @render
    BiggestMutualFund.fetch()

  render: =>
    mutual_funds = BiggestMutualFund.all()[0].aaData
    @html @view('biggest_mutual_funds/index')(biggest_mutual_funds: mutual_funds)

class App.MutualFundLosers extends Spine.Controller

  constructor: ->
    super
    MutualFundLoser.bind 'refresh change', @render
    MutualFundLoser.fetch()

  render: =>
    mutual_funds = MutualFundLoser.all()[0].aaData
    @html @view('mutual_fund_gainers/index')(mutual_funds: mutual_funds)



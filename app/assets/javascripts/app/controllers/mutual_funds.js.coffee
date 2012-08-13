$ = jQuery.sub()
MutualFundGainer = App.MutualFundGainer
BiggestMutualFund = App.BiggestMutualFund
MutualFundLoser = App.MutualFundLoser

class App.MutualFundGainers extends Spine.Controller
  className: 'mutual_fund_gainers stack'
  # elements:
  #   '.items': items
  #
  # events:
  #   'click .item': 'itemClick'

  constructor: (params)->
    super
    MutualFundGainer.bind 'refresh change', @render
    MutualFundGainer.fetch(params)

  render: =>
    mutual_funds = MutualFundGainer.all()[0].aaData
    @html @view('mutual_fund_gainers/index')(mutual_fund_gainers: mutual_funds)

class App.BiggestMutualFunds extends Spine.Controller
  className: 'biggest_mutual_funds stack'
  # elements:
  #   '.items': items
  #
  # events:
  #   'click .item': 'itemClick'

  constructor: ->
    super
    BiggestMutualFund.bind 'refresh change', @render
    BiggestMutualFund.fetch()

  render: =>
    mutual_funds = BiggestMutualFund.all()[0].aaData
    @html @view('biggest_mutual_funds/index')(biggest_mutual_funds: mutual_funds)

class App.MutualFundLosers extends Spine.Controller
  # elements:
  #   '.items': items
  #
  # events:
  #   'click .item': 'itemClick'

  constructor: ->
    super
    MutualFundLoser.bind 'refresh change', @render
    MutualFundLoser.fetch()

  render: =>
    mutual_funds = MutualFundLoser.all()[0].aaData
    @html @view('mutual_fund_losers/index')(mutual_fund_losers: mutual_funds)



$ = jQuery.sub()
MutualFundGainer = App.MutualFundGainer

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
    mutual_funds = MutualFundGainer.all()
    @html @view('mutual_fund_gainers/index')(mutual_fund_gainers: mutual_funds)

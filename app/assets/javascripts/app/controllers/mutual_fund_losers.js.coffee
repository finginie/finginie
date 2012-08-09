$ = jQuery.sub()
MutualFundLoser = App.MutualFundLoser

class Index extends Spine.Controller
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
    mutual_funds = MutualFundLoser.all()
    @html @view('mutual_fund_losers/index')(mutual_fund_losers: mutual_funds)

class App.MutualFundLosers extends Spine.Stack
  className: 'mutual_fund_losers stack'

  controllers:
    index: Index

  routes:
    '/mutual_fund_losers':  'index'
    '':                    'index'

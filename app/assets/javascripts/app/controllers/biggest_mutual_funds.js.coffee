$ = jQuery.sub()
BiggestMutualFund = App.BiggestMutualFund

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
    mutual_funds = BiggestMutualFund.all()
    @html @view('biggest_mutual_funds/index')(biggest_mutual_funds: mutual_funds)


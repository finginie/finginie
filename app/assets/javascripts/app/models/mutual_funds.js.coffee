class MutualFund extends Spine.Model
  @configure 'MutualFund', 'name', 'size','nav_amount', 'day_change', 'percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent', 'slug'
  @extend Spine.Model.Ajax

class App.MutualFundGainer extends MutualFund
  @url: "/mutual_funds?scope=top_gainers"

  @fetch: (params) ->
    params = {data:{limit:5}} unless params && params.data
    params.processData = true
    super(params)

class App.MutualFundLoser extends MutualFund
  @url: "/mutual_funds?scope=top_losers"

class App.BiggestMutualFund extends MutualFund
  @url: "/mutual_funds?scope=biggest_funds"

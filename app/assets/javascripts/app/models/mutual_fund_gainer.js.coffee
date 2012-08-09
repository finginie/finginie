class App.MutualFundGainer extends Spine.Model
  @configure 'MutualFundGainer', 'name', 'nav_amount', 'percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent', 'slug'
  @extend Spine.Model.Ajax

  @url: "/mutual_fund_gainers"

  @fetch: (params) ->
    params = {data:{limit:5}} unless params && params.data
    params.processData = true
    super(params)

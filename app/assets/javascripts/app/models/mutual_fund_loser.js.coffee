class App.MutualFundLoser extends Spine.Model
  @configure 'MutualFundLoser', 'name', 'nav_amount', 'percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent', 'slug'
  @extend Spine.Model.Ajax

  @url: "/mutual_funds?scope=top_losers"

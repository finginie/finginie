class App.BiggestMutualFund extends Spine.Model
  @configure 'BiggestMutualFund', 'name', 'size','nav_amount', 'day_change', 'percentage_change', 'prev1_month_percent', 'prev_year_percent', 'prev3_year_percent', 'slug'
  @extend Spine.Model.Ajax

  @url: "/biggest_mutual_funds"

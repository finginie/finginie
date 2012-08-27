class Finginie.Models.MutualFunds extends Backbone.Model
  paramRoot: 'mutual_fund'

  defaults:
    name: null
    nav_amount: null
    percentage_change: null
    size: null
    prev_year_percent: null
    prev1_month_percent: null
    prev3_year_percent: null

class Finginie.Collections.MutualFundsCollection extends Backbone.Collection
  model: Finginie.Models.MutualFunds
  url: '/data/mutual_funds'

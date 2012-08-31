class Finginie.Routers.HomeRouter extends Backbone.Router
  routes:
    ""    : "index"

  index: ->
    (new Finginie.Widgets.TrendingMutualFundsWidget(trend: 'desc')).render('#top_mutual_funds')
    (new Finginie.Widgets.TrendingMutualFundsWidget(trend: 'asc')).render('#lowest_mutual_funds')
    (new Finginie.Widgets.BiggestMutualFundsWidget()).render('#biggest_mutual_funds')
    (new Finginie.Widgets.NewsArticlesWidget(section: section)).render("#news_#{section}") for section in [ "markets", "economy", "companies", "global_news", "stock_tips" ]
    (new Finginie.Widgets.ResearchReportsWidget()).render('#research_reports')
    (new Finginie.Widgets.SectoralIndicesWidget(exchange: exchange)).render("##{exchange}_sectoral_indices") for exchange in ['Nse', 'Bse']
    @render_trending_shares(exchange) for exchange in ['Nse', 'Bse']

  render_trending_shares: (exchange)->
    (new Finginie.Widgets.TrendingSharesWidget(exchange: exchange, trend: trend)).render("##{exchange}_top_#{trend}") for trend in ['gainers', 'losers']
    (new Finginie.Widgets.MostActiveSharesWidget(exchange: exchange)).render("##{exchange}_most_active")

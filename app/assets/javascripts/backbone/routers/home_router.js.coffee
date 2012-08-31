class Finginie.Routers.HomeRouter extends Backbone.Router
  routes:
    ""    : "index"

  index: ->
    (new Finginie.Widgets.TrendingMutualFundsWidget(trend: 'desc')).render('#top_mutual_funds')
    (new Finginie.Widgets.TrendingMutualFundsWidget(trend: 'asc')).render('#lowest_mutual_funds')
    (new Finginie.Widgets.BiggestMutualFundsWidget()).render('#biggest_mutual_funds')
    @render_news_articles(section) for section in [ "markets", "economy", "companies", "global_news", "stock_tips" ]
    @render_research_reports()
    (new Finginie.Widgets.SectoralIndicesWidget(exchange: exchange)).render("##{exchange}_sectoral_indices") for exchange in ['Nse', 'Bse']
    @render_trending_shares(exchange) for exchange in ['Nse', 'Bse']

  render_trending_shares: (exchange)->
    (new Finginie.Widgets.TrendingSharesWidget(exchange: exchange, trend: trend)).render("##{exchange}_top_#{trend}") for trend in ['gainers', 'losers']
    (new Finginie.Widgets.MostActiveSharesWidget(exchange: exchange)).render("##{exchange}_most_active")

  render_news_articles: (section)->
    news_articles = new Finginie.Collections.NewsArticlesCollection()
    news_articles.fetch
      data:
        where: "this.section_name=='#{section}'"
        limit: 5
    view = new Finginie.Views.NewsArticles.NewsArticlesView(news_articles: news_articles)
    $("#news_#{section}").html(view.render().el)

  render_research_reports: ->
    research_reports = new Finginie.Collections.ResearchReportsCollection()
    research_reports.fetch
      data:
        limit: 5
    view = new Finginie.Views.ResearchReports.ResearchReportsView(research_reports: research_reports)
    $("#research_reports").html(view.render().el)


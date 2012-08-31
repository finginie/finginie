class Finginie.Routers.HomeRouter extends Backbone.Router
  routes:
    ""    : "index"

  index: ->
    (new Finginie.Widgets.TrendingMutualFundsWidget(trend: 'desc')).render('#top_mutual_funds')
    (new Finginie.Widgets.TrendingMutualFundsWidget(trend: 'asc')).render('#lowest_mutual_funds')
    @render_biggest_mutual_funds()
    @render_news_articles(section) for section in [ "markets", "economy", "companies", "global_news", "stock_tips" ]
    @render_research_reports()
    (new Finginie.Widgets.SectoralIndicesWidget(exchange: exchange)).render("##{exchange}_sectoral_indices") for exchange in ['Nse', 'Bse']
    @render_trending_shares(exchange) for exchange in ['Nse', 'Bse']

  render_biggest_mutual_funds: ->
    @biggest_mutual_funds = new Finginie.Collections.MutualFundsCollection()
    @biggest_mutual_funds.fetch
      data:
        desc: 'size'
        limit: 5
    @biggest_mutual_funds_view = new Finginie.Views.MutualFunds.BigMutualFundsView(mutual_funds: @biggest_mutual_funds)
    $("#biggest_mutual_funds").html(@biggest_mutual_funds_view.render().el)

  render_trending_shares: (exchange)->
    @render_top_shares exchange, 'gainers'
    @render_top_shares exchange, 'losers'
    @render_active_shares exchange

  render_top_shares: (exchange, trend)->
    scrips = new Finginie.Collections.ScripsCollection()
    data = exchange: exchange
    data["top_#{trend}"]= 5
    scrips.fetch
      data: data
    view = new Finginie.Views.Scrips.TrendingSharesView(scrips: scrips)
    $("##{exchange}_top_#{trend}").html(view.render().el)

  render_active_shares: (exchange)->
    scrips = new Finginie.Collections.ScripsCollection()
    scrips.fetch
      data:
        exchange: exchange
        most_active: 5
    view = new Finginie.Views.Scrips.MostActiveSharesView(scrips: scrips)
    $("##{exchange}_most_active").html(view.render().el)

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


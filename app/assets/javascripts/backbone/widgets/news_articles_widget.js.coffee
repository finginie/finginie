class Finginie.Widgets.NewsArticlesWidget
  constructor: (opts = {})->
    data = limit: 5
    data['where'] = "this.section_name=='#{opts.section}'" if opts.section?

    @news_articles = new Finginie.Collections.NewsArticlesCollection()
    @news_articles.fetch
      data: data

  render: (target)=>
    @view = new Finginie.Views.NewsArticles.NewsArticlesView(news_articles: @news_articles)
    $(target).html(@view.render().el)

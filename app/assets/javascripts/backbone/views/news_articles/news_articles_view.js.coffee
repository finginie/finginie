Finginie.Views.NewsArticles ||= {}

class Finginie.Views.NewsArticles.NewsArticlesView extends Backbone.View
  initialize: () ->
    @options.news_articles.bind('reset', @addAll)

  addAll: () =>
    @options.news_articles.each(@addOne)

  addOne: (news_article) =>
    view = new Finginie.Views.NewsArticles.NewsArticleView({model : news_article})
    $(@el).append(view.render().el)

  render: =>
    @addAll()

    return this

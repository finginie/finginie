Finginie.Views.NewsArticles ||= {}

class Finginie.Views.NewsArticles.NewsArticleView extends Backbone.View
  template: JST["backbone/templates/news_articles/news_article"]

  tagName: "article"

  render: =>
    $(@el).html(@template(@model.toJSON()))
    return this


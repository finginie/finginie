Finginie.Views.NewsArticles ||= {}

class Finginie.Views.NewsArticles.NewsArticleView extends Backbone.View
  template: JST["backbone/templates/news_articles/news_article"]

  tagName: "article"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @localize_date('published')

  localize_date: (attrs...)=>
    ret = {}
    for attr in attrs
      date = new Date(@model.get(attr))
      ret[attr] = date.toLocaleDateString() + ' ' + date.toLocaleTimeString()
    ret

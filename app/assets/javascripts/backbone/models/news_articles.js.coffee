class Finginie.Models.NewsArticles extends Backbone.Model
  paramRoot: 'news_article'

  defaults:
    published    : null
    section_name : null
    source       : null
    summary      : null
    title        : null
    url          : null

class Finginie.Collections.NewsArticlesCollection extends Backbone.Collection
  model: Finginie.Models.NewsArticles
  url: '/data/news_articles'

Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.SearchView extends Backbone.View
  el: '#stock_search'

  initialize: () ->
    _.bindAll(this, 'search', 'fetch')

    @$('input').bind('keypress', @search)

  search: () ->
    @t && clearTimeout @t
    @t = setTimeout(@fetch, 300)

    return this

  fetch: () ->
    @options.stocks.fetch {data: @$().serialize()}

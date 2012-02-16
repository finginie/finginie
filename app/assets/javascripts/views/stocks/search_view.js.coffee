Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.SearchView extends Backbone.View
  el: '#stock_search'

  initialize: () ->
    @$('input').bind('keypress', @search)
    @$('select').bind('change', @search)

  search: () =>
    @t && clearTimeout @t
    @t = setTimeout(@fetch, 300)

    this

  fetch: () =>
    @options.stocks.fetch {data: @$().serialize()}

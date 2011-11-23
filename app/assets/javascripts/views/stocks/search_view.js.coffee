Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.SearchView extends Backbone.View
  el: '#stock_search'

  initialize: () ->
    _.bindAll(this, 'search')

    @$('input').bind('keypress', @search)

  search: () ->
    @options.stocks.fetch {data: @$().serialize()}

    return this

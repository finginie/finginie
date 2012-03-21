Finginie.Views.Stocks ||= {}

class Finginie.Views.Stocks.SearchView extends Backbone.View
  el: '#stock_search'

  initialize: () ->
    @$('input').bind('keyup', @search)
    @$('select').bind('change', @search)
    @$('.loading').css 'visibility', 'hidden'

  search: () =>
    @t && clearTimeout @t
    @t = setTimeout(@fetch, 300)
    @$('.loading').css 'visibility', 'visible'

    this

  fetch: () =>
    @xhr && @xhr.abort()
    @xhr = @options.stocks.fetch
      data: @$().serialize()
      success: (model, response) =>
        @$('.loading').css 'visibility', 'hidden'

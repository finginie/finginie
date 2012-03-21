class Finginie.Models.Stock extends Backbone.Model
  paramRoot: 'stock'

class Finginie.Collections.StocksCollection extends Backbone.Collection
  model: Finginie.Models.Stock
  url: '/stocks'
  comparator: (stock) ->
    return stock.get('name')

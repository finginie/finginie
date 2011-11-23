class Finginie.Models.Stock extends Backbone.Model
  paramRoot: 'stock'

  defaults:
    name: null
    sector: null
    beta: null
    pe: null
    eps: null

class Finginie.Collections.StocksCollection extends Backbone.Collection
  model: Finginie.Models.Stock
  url: '/stocks'

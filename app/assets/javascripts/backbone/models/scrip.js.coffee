class Finginie.Models.Scrip extends Backbone.Model
  paramRoot: 'scrip'

  defaults:
    last_traded_price: null
    net_change: null
    percent_change: null

class Finginie.Collections.ScripsCollection extends Backbone.Collection
  model: Finginie.Models.Scrip
  url: '/data/tmp/sectoral_indices'

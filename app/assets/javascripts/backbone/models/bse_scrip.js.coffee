class Finginie.Models.BseScrip extends Backbone.Model
  paramRoot: 'bse_scrip'
  urlRoot: '/bse_scrips'

  defaults:
    last_traded_price: null
    net_change: null
    percent_change: null

class Finginie.Collections.BseScripsCollection extends Backbone.Collection
  model: Finginie.Models.BseScrip
  url: '/bse_scrips'

class Finginie.Models.NseScrip extends Backbone.Model
  paramRoot: 'nse_scrip'
  urlRoot: '/nse_scrips'

  defaults:
    last_traded_price: null
    net_change: null
    percent_change: null

class Finginie.Collections.NseScripsCollection extends Backbone.Collection
  model: Finginie.Models.NseScrip
  url: '/nse_scrips'

Finginie.Views.Indices ||= {}

class Finginie.Views.Indices.IndexView extends Backbone.View
  template: JST["backbone/templates/indices/index"]

  initialize: () ->
    @model.bind 'change', @render

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend @model.toJSON(),
      percent_change_color: @colorize(@model.get('percent_change'))
      last_traded_price: @money_to_d(@model.get('last_traded_price'))
      net_change: @money_to_d(@model.get('net_change'))
      net_change_color: @colorize(@money_to_d(@model.get('net_change')))

  money_to_d: (value)=>
    if value?
      value.cents/100

  colorize: (value)=>
    if value?
      if value < 0 then 'red' else 'green'

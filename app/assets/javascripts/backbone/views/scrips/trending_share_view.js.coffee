Finginie.Views.Scrips ||= {}

class Finginie.Views.Scrips.TrendingShareView extends Backbone.View
  template: JST["backbone/templates/scrips/trending_share"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @color_classes('percent_change'),
      @round('last_traded_price', 'percent_change')

  color_classes: (attrs...)=>
    color_classes = {}
    for attr in attrs
      value = @model.get attr
      color_classes["#{attr}_color"] = if value?
        if value < 0 then 'red' else 'green'
    color_classes

  round: (attrs...)=>
    ret = {}
    for attr in attrs
      ret[attr] = Math.round(@model.get(attr) * 100)/100
    ret

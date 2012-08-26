Finginie.Views.SectoralIndices ||= {}

class Finginie.Views.SectoralIndices.IndexView extends Backbone.View
  template: JST["backbone/templates/sectoral_indices/index"]

  tagName: "tr"

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @color_classes('net_change', 'percent_change'),
      @round('percent_change')

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

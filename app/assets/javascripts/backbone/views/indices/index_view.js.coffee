Finginie.Views.Indices ||= {}

class Finginie.Views.Indices.IndexView extends Backbone.View
  template: JST["backbone/templates/indices/index"]

  initialize: () ->
    @model.bind 'change', @render

  render: =>
    $(@el).html(@template(@attributes()))
    return this

  attributes: =>
    _.extend {},
      @model.toJSON(),
      @color_classes('percent_change', 'net_change')
      @round('percent_change', 'net_change', 'last_traded_price')

  color_classes: (attrs...)->
    color_classes = {}
    for attr in attrs
      value = @model.get attr
      color_classes["#{attr}_color"] = if value?
        if value < 0 then 'red' else 'green'
    color_classes

  round: (attrs...)->
    ret = {}
    for attr in attrs
      ret[attr] = Math.round(@model.get(attr) * 100)/100
    ret

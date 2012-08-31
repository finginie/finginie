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
      @model.color_classes('percent_change', 'net_change')
      @model.round('percent_change', 'net_change', 'last_traded_price')

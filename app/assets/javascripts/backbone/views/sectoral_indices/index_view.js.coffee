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
      @model.color_classes('net_change', 'percent_change'),
      @model.round('percent_change')

Finginie.Views.SectoralIndices ||= {}

class Finginie.Views.SectoralIndices.IndicesView extends Backbone.View
  template: JST["backbone/templates/sectoral_indices/indices"]

  initialize: () ->
    @options.indices.bind('reset', @addAll)

  addAll: () =>
    @options.indices.each(@addOne)

  addOne: (index) =>
    view = new Finginie.Views.SectoralIndices.IndexView({model : index})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(indices: @options.indices.toJSON() ))
    @addAll()

    return this

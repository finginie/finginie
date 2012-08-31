class Finginie.Widgets.SectoralIndicesWidget
  constructor: (opts={exchange: 'Nse'})->
    @sectoral_indices = new Finginie.Collections.ScripsCollection()
    @sectoral_indices.fetch
      data:
        exchange: opts.exchange
        sectoral_indices: 'all'

  render: (target)=>
    @view = new Finginie.Views.SectoralIndices.IndicesView(indices: @sectoral_indices)
    $(target).html(@view.render().el)

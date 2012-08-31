class Finginie.Widgets.ResearchReportsWidget
  constructor: ->
    @research_reports = new Finginie.Collections.ResearchReportsCollection()
    @research_reports.fetch
      data:
        limit: 5

  render: (target)=>
    @view = new Finginie.Views.ResearchReports.ResearchReportsView(research_reports: @research_reports)
    $(target).html(@view.render().el)

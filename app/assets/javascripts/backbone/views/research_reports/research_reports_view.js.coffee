Finginie.Views.ResearchReports ||= {}

class Finginie.Views.ResearchReports.ResearchReportsView extends Backbone.View
  template: JST["backbone/templates/research_reports/research_reports"]

  initialize: () ->
    @options.research_reports.bind('reset', @addAll)

  addAll: () =>
    @options.research_reports.each(@addOne)

  addOne: (research_report) =>
    view = new Finginie.Views.ResearchReports.ResearchReportView({model : research_report})
    @$("ul").append(view.render().el)

  render: =>
    $(@el).html(@template(research_reports: @options.research_reports.toJSON() ))
    @addAll()

    return this

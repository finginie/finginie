class Finginie.Models.ResearchReports extends Backbone.Model
  paramRoot: 'research_report'

  defaults:
    recommendation  : null
    link_url        : null
    name            : null
    source          : null

class Finginie.Collections.ResearchReportsCollection extends Backbone.Collection
  model: Finginie.Models.ResearchReports
  url: '/data/research_reports'

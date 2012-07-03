class DataProvider::Company
  def research_reports
    ResearchReport.where :nse_code => nse_code
  end
end

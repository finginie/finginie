class ResearchReportsController < InheritedResources::Base
  optional_belongs_to :stock, :parent_class => DataProvider::Company, :finder => :find_by_slug, :instance_name => 'company'

  def collection
    @search = DataProvider::Company.new
    conditions = params[:search] ? params[:search] : {}
    conditions.merge!({ :nse_code_contains => parent.nse_code, :bse_code_equals => parent.bse_code1 }) if parent
    @reports = ResearchReport.search(conditions)
    flash.now[:result] = @reports.count == 0 ? t('.empty_search') : (t('.results_for_search', :term => conditions[:source_or_company_name_or_sector_contains]) if params[:search])
    @reports
  end
end

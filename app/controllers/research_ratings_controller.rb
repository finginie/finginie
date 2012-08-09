class ResearchRatingsController < InheritedResources::Base
  actions :index

  def collection
    @company = DataProvider::Company.nifty.sort_by(&:rating).reverse
    CompanyDecorator.decorate(@company)
  end
end

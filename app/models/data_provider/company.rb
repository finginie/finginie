require File.expand_path('../../../../engines/data_provider/lib/data_provider/company.rb', __FILE__)
require File.expand_path('../../research_report.rb', __FILE__)

module DataProvider
	class Company
    scope :nifty, where(:security_code.in => Listing.nifty.map(&:security_code))

    def all_brokerages_recommendation_values
      report = ResearchReport.short_term(nse_code)
      report.map(&:recommendation_value)
    end

    def rating
      return 0 if all_brokerages_recommendation_values.empty?

      if brokerage_strong_recommendation_criteria?
        5
      else
        (all_brokerages_recommendation_values.sum.to_f / all_brokerages_recommendation_values.size).round
      end
    end

    def recommendation
      if brokerage_strong_recommendation_criteria?
        "Strong Buy"
      else
        ResearchReport::RECOMMENDATION[rating]
      end
    end

  private
    def brokerage_strong_recommendation_criteria?
      all_brokerages_recommendation_values.uniq.count == 1 && all_brokerages_recommendation_values.count(5) > 3
    end
  end
end
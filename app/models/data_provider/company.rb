require File.expand_path('../../../../engines/data_provider/lib/data_provider/company.rb', __FILE__)
require File.expand_path('../../research_report.rb', __FILE__)

module DataProvider
	class Company
    RECOMMENDATION = {
      ResearchReport::SELL       => 'Sell',
      ResearchReport::NEUTRAL    => 'Neutral',
      ResearchReport::ACCUMULATE => 'Accumulate',
      ResearchReport::BUY        => 'Buy'
    }

    scope :nifty, where(:security_code.in => Listing.nifty.map(&:security_code))

    def recommendation_value
      report = ResearchReport.short_term(ticker_name)
      report.map(&:recommendation_value)
    end

    def rating
      recommendation_value.size > 0 ? (recommendation_value.inject(:+).to_f / recommendation_value.size).round : 0
    end

    def recommendation
      if recommendation_value.uniq == 0 && recommendation_value.count(5) > 3
        "Strong Buy"
      else
        RECOMMENDATION[rating]
      end
    end
  end
end

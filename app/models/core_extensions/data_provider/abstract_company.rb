require 'kaminari'
require 'kaminari/models/mongoid_extension'

module AbstractCompany
  extend ActiveSupport::Concern

  included do
    scope :nifty, where(:security_code.in => DataProvider::Listing.nifty.map(&:security_code))
  end

  def rating
    return 0 if all_brokerages_recommendation_values.empty?

    @rating ||= if brokerage_strong_recommendation_criteria?
        5
      else
        (all_brokerages_recommendation_values.sum.to_f / all_brokerages_recommendation_values.size).round
      end
  end

  def recommendation
    @recommendation ||= if brokerage_strong_recommendation_criteria?
          "Strong Buy"
        else
          ResearchReport::RECOMMENDATION[rating]
        end
  end

private
  def brokerage_strong_recommendation_criteria?
    all_brokerages_recommendation_values.uniq.count == 1 && all_brokerages_recommendation_values.count(5) > 3
  end

  def all_brokerages_recommendation_values
    @report ||= ResearchReport.short_term(nse_code)
    @report.map(&:recommendation_value)
  end
end

DataProvider::Company.class_eval do
  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document
  include AbstractCompany;
end

class FixedDepositDetailDecorator < ApplicationDecorator
  decorates :fixed_deposit_detail
  include Draper::LazyHelpers
  include NumberHelper

  def result_summary
    attributes = {amount: amount }
    time_duration  = ""
    time_duration += " #{duration[:year]} years"   if duration[:year].empty?
    time_duration += ", #{duration[:month]} months" if duration[:month].empty?
    time_duration += ", #{duration[:day]} days"     if duration[:days].empty?

    attributes[:duration] = time_duration.empty? ? time_duration : "1 years"
    attributes[:citizen] = senior_citizen == "rate_of_interest_senior_citizen" ? "senior citizen" : "non senior citizen"
    attributes
    h.t("fixed_deposit_result_summary", attributes)
  end
end

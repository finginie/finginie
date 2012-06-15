class FixedDepositDetailDecorator < ApplicationDecorator
  decorates :fixed_deposit_detail_proxy
  include Draper::LazyHelpers
  include NumberHelper

  def result_summary(default= false)
    attributes = {amount: amount }
    time_duration  = ""
    time_duration += "#{pluralize(duration[:year].to_i, 'year')}"   unless duration[:year].empty?
    time_duration += " #{pluralize(duration[:month].to_i, 'month')}" unless duration[:month].empty?
    time_duration += " #{pluralize(duration[:days].to_i, 'day')}"     unless duration[:days].empty?

    attributes[:duration] = time_duration.empty? ? "1 year" : time_duration
    attributes[:citizen] = senior_citizen == "rate_of_interest_senior_citizen" ? "senior citizen" : "non senior citizen"
    unless default
      h.t("fixed_deposit_result_summary", attributes)
    else
      h.t("fixed_deposit_no_result_summary", attributes)
    end
  end
end

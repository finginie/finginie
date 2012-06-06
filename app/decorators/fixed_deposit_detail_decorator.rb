class FixedDepositDetailDecorator < ApplicationDecorator
  decorates :fixed_deposit_detail
  include Draper::LazyHelpers
  include NumberHelper

  def result_summary(default= false)
    attributes = {amount: number_to_indian_currency(amount) }
    time_duration  = ""
    time_duration += "#{pluralize(year, 'year')}"    if year
    time_duration += " #{pluralize(month, 'month')}" if month
    time_duration += " #{pluralize(days, 'day')}"    if days

    attributes[:duration] = time_duration.empty? ? "1 year" : time_duration
    attributes[:citizen] = senior_citizen? ? "senior citizen" : "non senior citizen"
    unless default
      h.t("fixed_deposit_result_summary", attributes)
    else
      h.t("fixed_deposit_no_result_summary", attributes)
    end
  end

  def senior_citizen?
    senior_citizen == "Yes"
  end
end

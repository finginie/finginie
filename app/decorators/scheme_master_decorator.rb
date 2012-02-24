class SchemeMasterDecorator < ApplicationDecorator
  decorates :scheme_master

  FIELDS_TO_ROUND = [ 'percentage', 'nav_amount', 'percentage_change', 'dividend_percentage', 'day_change', 'prev1_week_per',
                      'prev1_month_per', 'prev3_months_per', 'prev6_months_per', 'prev9_months_per', 'prev_year_per', 'prev2_year_comp_per', 'prev3_year_comp_per',
                      'one_day_return', 'one_week_return', 'one_month_return', 'three_months_return', 'six_months_return', 'nine_months_return', 'one_year_return',
                      'two_year_return', 'three_year_return' ]
  def sip
    if model.sip == "True"
      "Yes"
    else
      "No"
    end
  end

  [ :company_name, :objective, :bench_mark_index, :dividend_percentage, :dividend_date, :entry_load, :exit_load ].each do |attr|
    define_method "#{attr}" do                            # def attr
      model.send(attr) || "-"                            #   model.attr || "NA"
    end                                                   # end
  end                                                     ##

  FIELDS_TO_ROUND.each do |key|
    define_method(key.to_sym) do
      model.send(key.to_sym) ? model.send(key.to_sym).round(2).to_f : h.t('tables_not_available')
    end
  end

  def scheme_returns
    [ prev1_week_per, prev1_month_per, prev3_months_per, prev6_months_per, prev9_months_per, prev_year_per, prev2_year_comp_per, prev3_year_comp_per ]
  end

  def category_returns
    [ one_week_return, one_month_return, three_months_return, six_months_return, nine_months_return, one_year_return, two_year_return, three_year_return]
  end

  def top_ten_holdings_percentages
    model.portfolio_holdings.take(10).map { |p| [ p["InvestedCompanyName"] , p["Percentage"].to_f.round(2) ] } if model.portfolio_holdings
  end

end

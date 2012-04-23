class SchemeDecorator < ApplicationDecorator
  decorates :scheme

  FIELDS_TO_ROUND = [ 'percentage', 'nav_amount', 'percentage_change', 'dividend_percentage', 'day_change', 'prev1_week_percent',
                      'prev1_month_percent', 'prev3_months_percent', 'prev6_months_percent', 'prev9_months_percent', 'prev_year_percent', 'prev2_year_comp_percent', 'prev3_year_comp_percent',
                      'one_day_return', 'one_week_return', 'one_month_return', 'three_months_return', 'six_months_return', 'nine_months_return', 'one_year_return',
                      'two_year_return', 'three_year_return' ]
  def sip
    if model.sip == "True"
      "Yes"
    else
      "No"
    end
  end

  [ :company_name, :objective, :bench_mark_index_name, :dividend_percentage, :dividend_date, :entry_load, :exit_load ].each do |attr|
    define_method "#{attr}" do                            # def attr
      model.send(attr) || "-"                            #   model.attr || "NA"
    end                                                   # end
  end                                                     ##

  FIELDS_TO_ROUND.each do |key|
    define_method(key.to_sym) do
      model.send(key.to_sym) ? model.send(key.to_sym).round(2).to_f : h.t('tables_not_available')
    end
  end

  def comparative_returns_data_table
    [ ['Time Frame', 'Scheme Returns',        'Category Returns'  ],
      ['1 week',      prev1_week_percent,      one_week_return    ],
      ['1 month',     prev1_month_percent,     one_month_return   ],
      ['3 months',    prev3_months_percent,    three_months_return],
      ['6 months',    prev6_months_percent,    six_months_return  ],
      ['9 months',    prev9_months_percent,    nine_months_return ],
      ['1 year',      prev_year_percent,       one_year_return    ],
      ['2 years',     prev2_year_comp_percent, two_year_return    ],
      ['3 years',     prev3_year_comp_percent, three_months_return] ]
  end

  def top_ten_holdings_percentages
    model.portfolio_holdings.take(10).map { |p| [ p["InvestedCompanyName"] , p["Percentage"].to_f.round(2) ] } if model.portfolio_holdings
  end

end

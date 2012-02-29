class ShareHoldingDecorator < ApplicationDecorator
  decorates :share_holding

  SHARE_HOLDING_CODES = { "foreign_institutional_investors_percentage" =>  [ { :code => "1383", :name => "Foreign Institutions" } ] ,
                          "domestic_institutional_investors_percentage" => [ { :code => "1395", :name => "Mutual Funds" },
                                                                             { :code => "2001", :name => "Financial Institutions" } ],
                          "other_foreign_investors_percentage" =>          [ { :code => "1385", :name => "Foreign Non Resident Indians" },
                                                                             { :code => "1386", :name => "Foreign Overseas Corporate Bodies" },
                                                                             { :code => "1387", :name => "Foreign Others" },
                                                                             { :code => "1384", :name => "Foreign Nationals" },
                                                                             { :code => "2015", :name => "GDR" } ],
                          "promoters_percentage" =>                        [ { :code => "2013", :name => "Foreign Promoter" },
                                                                             { :code => "1405", :name => "Indian Promoters" } ],
                          "directors_and_employees_percentage" =>          [ { :code => "2022", :name => "Employees" },
                                                                             { :code => "1406", :name => "Directors" } ],
                          "others_percentage" =>                           [ { :code => "1397", :name => "Central Government" },
                                                                             { :code => "1403", :name => "Other Companies" },
                                                                             { :code => "1404", :name => "Others" } ],
                          "public_percentage" =>                           [ { :code => "1407", :name => "General Public" } ] }

  def element
    model.element.each do |e|
      e.merge!("Percentage" => (e["EquityShareHold"].to_f*100/e["TotalNoOfShares"].to_f).round(2))
    end
    model.element
  end

  SHARE_HOLDING_CODES.keys.each do |key|
    define_method(key.to_sym) do
      ( SHARE_HOLDING_CODES[key].map { |e| get_element_by_code(e[:code])["Percentage"] } - [ nil ] ).sum.round(2)
    end
  end

  def get_element_by_code(code)
    element.select { |e| e["ShareHolderCode"] == code }.first || {}
  end

  def share_holder_codes
    element.map { |e| e["ShareHolderCode"] }
  end

  def non_zero_groups
    (SHARE_HOLDING_CODES.keys.map { |key|  { :group => key, :group_total => send(key)} if send(key) != 0.0 } - [nil])
      .sort_by { |item| -item[:group_total] }.map { |item| item[:group] }
  end

  def groupwise_percentages
    non_zero_groups.map { |key| [ h.t("share_holding.#{key}"), send(key)] }
  end
end

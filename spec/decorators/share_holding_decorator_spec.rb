require 'spec_helper'

describe ShareHoldingDecorator, :mongoid do
  before { ApplicationController.new.set_current_view_context }
  let(:company) { create :company }
  let(:share_holding) { create :share_holding, :company_code => company.code }
  let(:share_holding_decorator) { ShareHoldingDecorator.decorate(share_holding) }

  subject { share_holding_decorator }

  its(:share_holder_codes) { should include("1383", "1385", "1395", "1403", "1404", "1405", "1407", "2001", "2013") }
  it "should get the element by code" do
    share_holding_decorator.get_element_by_code("1385")["Percentage"].should eq 0.24
  end

  its(:foreign_institutional_investors_percentage) { should eq 8.52 }
  its(:domestic_institutional_investors_percentage) { should eq 3.0 }
  its(:other_foreign_investors_percentage) { should eq 0.24 }
  its(:promoters_percentage) { should eq 77.99 }
  its(:directors_and_employees_percentage) { should eq 0.0 }
  its(:others_percentage) { should eq 3.7 }
  its(:public_percentage) { should eq 6.56 }
  its(:non_zero_groups) { should eq [ "promoters_percentage",
                                      "foreign_institutional_investors_percentage",
                                      "public_percentage",
                                      "others_percentage",
                                      "domestic_institutional_investors_percentage",
                                      "other_foreign_investors_percentage" ] }
  its(:groupwise_percentages) { should eq [ [ 'Promoters',                              77.99],
                                            [ 'Foreign Institional Investors (FIIs)',   8.52 ],
                                            [ 'Public',                                 6.56 ],
                                            [ 'Others',                                 3.7  ],
                                            [ 'Domestic Institutional Investors (DIIs)',3.0  ],
                                            [ 'Other Foreign Investors',                0.24 ] ] }
end

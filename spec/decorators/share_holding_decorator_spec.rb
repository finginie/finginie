require 'spec_helper'

describe ShareHoldingDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company_master) { create :company_master }
  let(:share_holding) { create :share_holding, :company_code => company_master.company_code }
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
end

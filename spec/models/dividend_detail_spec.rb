require 'spec_helper'

describe DividendDetail do
  let(:company_master) { create :company_master }
  let(:dividend) { create :dividend_detail, :company_code => company_master.company_code, :date_of_announcement => "31/12/2011", :instrument_type => '1', :percentage => '15' }
  subject { dividend }

  its(:percentage) { should eq BigDecimal.new('15') }
  it "should find the record" do
    DividendDetail.find_or_initialize_by( company_code: company_master.company_code, :date_of_announcement => dividend.date_of_announcement ).should eq dividend
  end
end

require 'spec_helper'

describe CompanyMaster do
  let(:company_master) { create :company_master }

  subject { company_master }
  it { should validate_presence_of :company_code }
  it "should get the company record" do
    CompanyMaster.find_or_initialize_by( company_code: company_master.company_code ).should eq company_master
  end
end

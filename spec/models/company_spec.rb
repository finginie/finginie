require 'spec_helper'

describe Company do
  let(:company) { create :company }

  subject { company }
  it { should validate_presence_of :company_code }
  it "should get the company record" do
    Company.find_or_initialize_by( company_code: company.company_code ).should eq company
  end
end

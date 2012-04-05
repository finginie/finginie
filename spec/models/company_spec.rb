require 'spec_helper'

describe Company do
  let(:company) { create :company }

  subject { company }
  it { should validate_presence_of :company_code }
  it { should validate_presence_of :company_name }
  it { should validate_uniqueness_of(:company_code).with_message(/is already taken/) }
  it { should validate_uniqueness_of(:company_name).with_message(/is already taken/) }
  it "should get the company record" do
    Company.find_or_initialize_by( company_code: company.company_code ).should eq company
  end

end

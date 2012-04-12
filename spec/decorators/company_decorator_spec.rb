require 'spec_helper'

describe CompanyDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company) {create :company, :eps => '1424.32001' }
  let(:share_holding) { create :share_holding, :company_code => company.company_code }
  let(:company_decorator) { CompanyDecorator.decorate(company) }
  subject { company_decorator }

  its(:eps) { should eq 1424.32 }

  it "should have all share_holding percentages", :mongoid do
    share_holding.save
    subject.share_holding.foreign_institutional_investors_percentage.should eq 8.52
  end
end

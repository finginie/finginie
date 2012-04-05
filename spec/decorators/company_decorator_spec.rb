require 'spec_helper'

describe CompanyDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company) {create :company, :eps => '1424.32001' }
  let(:company_decorator) { CompanyDecorator.decorate(company) }
  subject { company_decorator }

  its(:eps) { should eq 1424.32 }
  its(:fifty_two_week_high_price) { should eq "N/A" }
end

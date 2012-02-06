require 'spec_helper'

describe AuditedResult do
  let(:company_master) { create :company_master }
  let(:audited_result) { create :audited_result, :companycode => company_master.company_code, :year_ending => "31/03/2011", :material_consumed => "234566788"  }
  subject { audited_result }

  its(:material_consumed) { should eq BigDecimal.new("234566788") }
  it "should get the record" do
    AuditedResult.where( companycode: company_master.company_code, :year_ending => audited_result.year_ending ).first.should eq audited_result
  end
end

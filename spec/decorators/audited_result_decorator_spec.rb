require 'spec_helper'

describe AuditedResultDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company_master) { create :company_master }
  let(:audited_result) { create :audited_result, :companycode            => company_master.company_code,
                                                 :investments            => "2956005690000",
                                                 :equity_capital         => "6349990000",
                                                 :long_term_loan         => "111111111",
                                                 :unsecured_term_loans   => "121223344",
                                                 :numberof_equity_shares => "634998991"
  }

  let(:audited_result_decorator) { AuditedResultDecorator.decorate audited_result }
  subject { audited_result_decorator }

  describe "should divide all bigdecimals by a crore" do
    its(:investments)    { should eq 295600.57 }
    its(:equity_capital) { should eq 635.0 }
    its(:long_term_loan) { should eq 11.11 }
    its(:total_debt)     { should eq 23.23 }
  end

  its(:number_of_equity_shares) { should eq 6349.99 }

  it "should get correct balance_sheet view_items for non-banking sector" do
    audited_result_decorator.balance_sheet_view_items.map { |item| item[:field_name] }.should include( "total_debt", "total_share_capital", "inventory", "revaluation_reserve", "long_term_loan", "unsecured_term_loans" )
  end

  it "should get the correct balance_sheet view_items for banking sector" do
    company_master.update_attribute(:major_sector, 2)
    audited_result_decorator.balance_sheet_view_items.map { |item| item[:field_name] }.should include( "advances", "borrowings_by_bank", "unsecured_loans", "savings_deposits_un_secured", "dep_of_ind_branches" )
   end
  it "should get the company name" do
    audited_result_decorator.company_name.should eq company_master.company_name
  end
end

require 'spec_helper'

describe AuditedResultDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company) { create :company }
  let(:audited_result) { create :audited_result, :companycode            => company.company_code,
                                                 :investments            => "2956005690000",
                                                 :equity_capital         => "6349990000",
                                                 :long_term_loan         => "111111111",
                                                 :unsecured_term_loans   => "121223344",
                                                 :numberof_equity_shares => "634998991",
                                                 :fundbased_income       => "831496759000",
                                                 :financial_expences     => "4886795610",
                                                 :adjusted_pat           => "82830297000",
                                                 :retained_earnings      => "52191698000"
  }

  let(:audited_result_decorator) { AuditedResultDecorator.decorate audited_result }
  subject { audited_result_decorator }

  describe "should divide all bigdecimals by a crore" do
    its(:investments)    { should eq 295600.57 }
    its(:equity_capital) { should eq 635.0 }
    its(:long_term_loan) { should eq 11.11 }
    its(:total_debt)     { should eq 23.23 }
    its(:fundbased_income)   { should eq 83149.68 }
    its(:financial_expences) { should eq 488.68 }
    its(:adjusted_pat)       { should eq 8283.03 }
    its(:retained_earnings)  { should eq 5219.17 }
  end

  its(:number_of_equity_shares) { should eq 6349.99 }

  it "should get correct balance_sheet view_items for non-banking sector" do
    audited_result_decorator.balance_sheet_view_items.map { |item| item[:field_name] }.should include( "total_debt", "total_share_capital", "inventory", "revaluation_reserve", "long_term_loan", "unsecured_term_loans" )
  end

  describe "for banking sector" do
    before(:each) { company.update_attribute(:major_sector, 2) }

    it "should get the correct balance_sheet view_items" do
      audited_result_decorator.balance_sheet_view_items.map { |item| item[:field_name] }.should include( "advances", "borrowings_by_bank", "unsecured_loans", "savings_deposits_un_secured", "dep_of_ind_branches" )
    end

    it "should get the correct profit_loss view_items" do
      audited_result_decorator.profit_loss_view_items.map { |item| item[:field_name] }.should include( 'fundbased_income', 'feebased_income', 'pl_onsaleof_invstmts', 'exchg_rate_fluct', 'operating_income', 'banks_provisions_made' )
    end
  end

  it "should get the company name" do
    audited_result_decorator.company_name.should eq company.company_name
  end
end

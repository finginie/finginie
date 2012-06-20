require 'spec_helper'

describe CashFlowDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company) { create :'data_provider/company' }
  let(:cash_flow)      { create :'data_provider/cash_flow', :company_code => company.code,
                                            :profits_before_tax         => "139260961000",
                                            :interest_paid_net  => "25386722000",
                                            :provisions_dimun_in_value_of_investment  => "-9685958000",
                                            :provisions_for_bad_debts_npa   => "51478528000"
  }
  let(:cash_flow_decorator) { CashFlowDecorator.decorate cash_flow }
  subject { cash_flow_decorator }

  describe "should divide all bigdecimals by a crore" do
    its(:profits_before_tax)           { should eq 13926 }
    its(:interest_paid_net)  { should eq 2539 }
    its(:provisions_dimun_in_value_of_investment)  { should eq -969 }
    its(:provisions_for_bad_debts_npa)    { should eq 5148 }

  end
end

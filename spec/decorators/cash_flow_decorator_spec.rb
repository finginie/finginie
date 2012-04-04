require 'spec_helper'

describe CashFlowDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:company) { create :company }
  let(:cash_flow)      { create :cash_flow, :company_code => company.company_code,
                                            :pbt	        => "139260961000",
                                            :int_paid_net	=> "25386722000",
                                            :prov_dim_inv	=> "-9685958000",
                                            :prov_bdnpa  	=> "51478528000"
  }
  let(:cash_flow_decorator) { CashFlowDecorator.decorate cash_flow }
  subject { cash_flow_decorator }

  describe "should divide all bigdecimals by a crore" do
    its(:pbt)           { should eq 13926.1 }
    its(:int_paid_net)  { should eq 2538.67 }
    its(:prov_dim_inv)  { should eq -968.6}
    its(:prov_bdnpa)    { should eq 5147.85 }

  end
end

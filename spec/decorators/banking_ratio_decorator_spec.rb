require 'spec_helper'

describe BankingRatioDecorator do
  before { ApplicationController.new.set_current_view_context }
  let(:banking_ratio) { create :banking_ratio, :adjusted_return_on_net_worth => "1.233455",
                                               :cost_of_funds_ratio  => "2.3455" }
  let(:banking_ratio_decorator) { BankingRatioDecorator.decorate banking_ratio }
  subject { banking_ratio_decorator }

  its(:adjusted_return_on_net_worth) { should eq 1.23 }
  its(:cost_of_funds_ratio)          { should eq 2.35 }
  its(:net_profit_margin)            { should eq "NA" }
end

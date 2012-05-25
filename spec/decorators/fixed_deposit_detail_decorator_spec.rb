require 'spec_helper'

describe FixedDepositDetailDecorator do

  let (:fixed_deposit_detail) { FixedDepositDetailProxy.new(amount: "100", duration: {year: "1", month: "", days: ""}, senior_citizen: "rate_of_interest_senior_citizen")}
  let (:fixed_deposit_detail_decorator) { FixedDepositDetailDecorator.decorate fixed_deposit_detail }

  subject { fixed_deposit_detail_decorator }

  it "should return summary params of fixed deposit results" do
    fixed_deposit_detail_decorator.result_summary.should eq I18n.t("fixed_deposit_result_summary", amount: "100", duration: "1 year", citizen: "senior citizen")
  end
end

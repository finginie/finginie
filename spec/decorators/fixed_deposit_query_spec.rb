require 'spec_helper'

describe FixedDepositQueryDecorator do

  let (:fixed_deposit_detail) { FixedDepositQuery.new(amount: "100", year: "1", month: "1", days: "1", senior_citizen: "Yes")}
  let (:fixed_deposit_detail_decorator) { FixedDepositQueryDecorator.decorate fixed_deposit_detail }

  subject { fixed_deposit_detail_decorator }

  it "should return summary params of fixed deposit results" do
    fixed_deposit_detail_decorator.result_summary.should eq I18n.t("fixed_deposit_result_summary", amount: "100.00", duration: "1 year 1 month 1 day", citizen: "senior citizen")
  end
end

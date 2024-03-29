require 'spec_helper'

describe MutualFund do
  let (:mutual_fund) { create :mutual_fund , :scheme => "Foo 1"}
  subject { mutual_fund }

  describe "with scheme master", :mongoid do
    let(:scheme) { create :'data_provider/scheme', :name => mutual_fund.scheme }

    it "should return nav amount" do
      scheme.update_attributes(:nav_amount => 220)
      mutual_fund.nav_amount.should be_a_indian_currency_of 220
      mutual_fund.current_price.should be_a_indian_currency_of 220
    end

    its(:nav_amount) { should eq nil }
    its(:current_price) { should be_nil }
  end
end

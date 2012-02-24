require 'spec_helper'

describe MutualFund do
  let (:mutual_fund) { create :mutual_fund , :scheme => "Foo 1"}
  subject { mutual_fund }

  describe "with scheme master", :mongoid do
    let(:scheme_master) { create :scheme_master, :scheme_name => mutual_fund.scheme }

    it "should return nav amount" do
      create :mfnav_detail, :nav_amount => 220, :security_code => scheme_master.securitycode
      mutual_fund.nav_amount.should eq 220
      mutual_fund.current_price.should eq 220
    end

    its(:nav_amount) { should eq nil }
    its(:current_price) { should be_nil }
  end
end

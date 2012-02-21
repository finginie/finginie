require 'spec_helper'

describe MutualFund do
  let (:mutual_fund) { create :mutual_fund , :scheme => "Foo 1"}
  subject { mutual_fund }

  describe "with scheme master", :mongoid do
    before :each do
      scheme_master = create :scheme_master, :scheme_name => mutual_fund.scheme
      create :mfnav_detail, :nav_amount => 220, :security_code => scheme_master.securitycode
    end

    its(:nav_amount) { should eq 220 }
  end
end


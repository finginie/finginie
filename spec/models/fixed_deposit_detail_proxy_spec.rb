require 'spec_helper'

describe FixedDepositDetailProxy do
  it "should proxy fixed deposit detail" do
    data = ["7", "15", "10.5", "11.5", "0", "1500000", "SBI", "PUBLIC"]
    fd_proxy = FixedDepositDetailProxy.new(FixedDepositDetail.new(1, data).attributes)
    fd_proxy.min_duration.should eq 7
  end
end

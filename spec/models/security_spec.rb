require 'spec_helper'

describe Security do
  it { should validate_presence_of :name }
  it "should build the right class based on the type" do
    Security.new(:type => 'Loan').should be_kind_of Loan
  end
end

require 'spec_helper'

describe SipCalculator do
  it { should validate_presence_of     :monthly_amount      }
  it { should validate_presence_of     :rate_of_return      }
  it { should validate_presence_of     :no_months           }
  it { should validate_numericality_of :initial_investment  }
  it { should validate_numericality_of :monthly_amount      }
  it { should validate_numericality_of :rate_of_return      }
  it { should validate_numericality_of :no_months           }
  it { should_not allow_value(0).for   :initial_investment  }
  it { should_not allow_value(0).for   :monthly_amount      }
  it { should_not allow_value(0).for   :rate_of_return      }
  it { should_not allow_value(0).for   :no_months           }
  it { should_not allow_value(6.5).for :no_months           }

  it "should calculate the right sip" do
    SipCalculator.new(
      :initial_investment => 1,
      :monthly_amount => 2000,
      :no_months => 12,
      :rate_of_return => 10
    ).calculate_sip.should eq 25341.67

    SipCalculator.new(
      :initial_investment => 1,
      :monthly_amount => 5000,
      :no_months => 24,
      :rate_of_return => 14.5
    ).calculate_sip.should eq 139922.9

    SipCalculator.new(
      :initial_investment => 1,
      :monthly_amount => 7000,
      :no_months => 48,
      :rate_of_return => 13
    ).calculate_sip.should eq 442402.67

  end
end

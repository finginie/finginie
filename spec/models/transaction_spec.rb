require 'spec_helper'

describe Transaction do
  it { should validate_presence_of :date }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :net_position_id }
end

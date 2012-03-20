require 'spec_helper'

describe RealEstate do
  let (:real_estate) { create :real_estate}
  it { should validate_presence_of :current_price }
  it { should validate_numericality_of :current_price }
  it { should_not allow_value(-1).for(:current_price) }
end

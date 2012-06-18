require 'spec_helper'

describe RealEstate do
  let (:real_estate) { create :real_estate}
  it { should validate_presence_of :current_price }
  it { should validate_numericality_of :current_price }
  it { should_not allow_value(-1).for(:current_price) }

  it "should delete associate child records" do
    real_estate = create :real_estate
    create :real_estate_transaction, :real_estate => real_estate
    lambda {
        real_estate.destroy
    }.should change(RealEstateTransaction, :count).by(-1)
  end
end

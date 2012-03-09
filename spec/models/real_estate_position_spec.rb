require 'spec_helper'

describe "RealEstatePosition" do
  let(:portfolio) { create :portfolio }
  let (:real_estate) { create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000 }

  subject {
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 50000, :date => Date.civil(2011, 12, 01)
    portfolio.real_estate_positions.first
  }

  its(:name) { should eq "Test Property" }
  its(:current_value) {  should eq 60000 }
  its(:buy_value) {  should eq 50000 }
  its(:unrealised_profit) {  should eq 10000 }
end

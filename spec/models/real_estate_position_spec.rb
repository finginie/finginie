require 'spec_helper'

describe "RealEstatePosition" do
  let(:portfolio) { create :portfolio }
  let (:real_estate) { create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000 }

  subject {
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 50000, :date => Date.civil(2011, 12, 01)
    portfolio.real_estate_positions.first
  }

  its(:name)                          { should eq "Test Property"   }
  its(:current_value)                 { should be_a_indian_currency_of 60000  }
  its(:buy_value)                     { should be_a_indian_currency_of 50000  }
  its(:unrealised_profit)             { should be_a_indian_currency_of 10000  }
  its(:unrealised_profit_percentage)  { should eq  20               }

  it "should calculate profit or loss percentage" do
    subject
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 55000, :action => "sell", :date => Date.civil(2011, 12, 02)
    subject.all # reload all the transactions
    subject.profit_or_loss.should be_a_indian_currency_of 5000
    subject.profit_or_loss_percentage.should eq 10
  end

  it "should have profit or loss for the same date sells" do
    subject
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 55000, :action => "sell", :date => Date.civil(2011, 12, 01)
    subject.all # reload all the transactions
    subject.profit_or_loss.should be_a_indian_currency_of 5000
    subject.profit_or_loss_percentage.should eq 10
  end
end

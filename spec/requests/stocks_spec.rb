require 'spec_helper'

describe "Stocks" do
  let (:portfolio) { create :portfolio }
  let (:stock) { create :stock }
  let (:net_position) { create :net_position, :stock => stock, :portfolio => portfolio }
  before do
    stock.transactions.create( :quantity => 100, :price => 653, :date => 1.day.ago )
    stock.transactions.create( :quantity => -57, :price => 700, :date => 2.days.ago )
  end

end

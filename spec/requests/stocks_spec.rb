require 'spec_helper'

describe "Stocks" do
  let (:stock) { create :stock }
  let (:scrip) { create :scrip, :id => stock.id, :last_traded_price => 24.22 }

  it "shows the stock details" do
    scrip.save
    visit stock_path stock
    page.should have_content 24.22
  end
end

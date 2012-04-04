require 'spec_helper'

describe "News", :mongoid do
  let(:stock) { create :stock }
  before :each do
    @company = create :company, :company_code => "123234", :nse_code => stock.symbol
    6.times { |i| create :news, :company_code => @company.company_code, :headlines => "headlines #{i}", :notes => "NOTES #{i}", :modify_on => Time.now - i }
  end

  it "should show the news page for a headline" do
    visit stock_news_path(:stock_id => stock.id, :id => "headlines 0")
    page.should have_content "headlines 0"
    page.should have_content "NOTES 0"
  end

end


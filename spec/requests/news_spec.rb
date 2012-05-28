require 'spec_helper'

describe "News", :mongoid do
  let(:company) { create :company }
  before :each do
    @news = create :news, :company_code => company.code, :headlines => "headlines 0", :notes => "NOTES 0", :modify_on => Time.now
  end

  it "should show the news page for a headline" do
    visit stock_news_path(:stock_id => company.code, :id => @news._id)
    page.should have_content "headlines 0"
    page.should have_content "NOTES 0"
  end

end


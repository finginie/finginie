require 'spec_helper'

describe Scheme do
  before(:each) do
    @scheme = create :scheme, :objective => "MyObjective",:bench_mark_index_name => "Crisil Liquid Fund Index"
    @amc =  create :asset_management_company, :company_code => @scheme.company_code, :company_name => "HDFC Mutual Fund"
    @navcp = create :navcp, :security_code => @scheme.securitycode
    @mf_dividend_detail = create :mf_dividend_detail, :securitycode => @scheme.securitycode
    @nav_category_detail = create :nav_category_detail, :scheme_class_code => @scheme.scheme_class_code
    @mf_scheme_wise_portfolio = create :mf_scheme_wise_portfolio, :security_code => @scheme.securitycode
  end

  subject { @scheme }

  its(:objective) { should eq @scheme.objective }
  its(:company_name) { should eq @amc.company_name }
  its(:bench_mark_index_name) { should eq @scheme.bench_mark_index_name }
  its(:dividend_percentage) { should eq @mf_dividend_detail.percentage }
  its(:dividend_date) { should eq @mf_dividend_detail.dividend_date }
  its(:one_day_return) { should eq @nav_category_detail.one_day_return }
  its(:one_year_return) { should eq @nav_category_detail.one_year_return }
  its(:prev1_week_per) { should eq @navcp.prev1_week_per }
  its(:prev3_months_per) { should eq @navcp.prev3_months_per }
  its(:prev9_months_per) { should eq @navcp.prev9_months_per }
  its(:prev3_year_comp_per) { should eq @navcp.prev3_year_comp_per }
  it "should have portfolio_holdings" do
    subject.portfolio_holdings.should include ({"PortfolioUOM"=>"838",
      "PortfolioUOMDescription"=>"Crores",
      "InvestedCompanyCode"=>"0",
      "InvestedCompanyName"=>"Axis Bank Ltd.",
      "IndustryCode"=>"0",
      "IndustryName"=>nil,
      "InstrumentCode"=>"2356",
      "InstrumentName"=>"Bills Rediscounting",
      "ListingInformation"=>"False",
      "Percentage"=>"5.05",
      "IsItNPA"=>"False",
      "MarketValue"=>"84.355",
      "Rating"=>"CRISILA1+",
      "RatingAgencyCode"=>"0",
      "RatingAgencyName"=>nil,
      "NetAsset"=>"0",
      "Modifyon"=>"14/02/2012 10:32",
      "RowId"=>"1"} )
  end

end

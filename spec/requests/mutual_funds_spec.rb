require 'spec_helper'

describe "MutualFunds" do
  before(:each) do
    @scheme_master = create :scheme_master
    @fund_master =  create :fund_master, :company_code => @scheme_master.company_code, :company_name => "HDFC Mutual Fund"
    @nav_master = create :nav_master, :security_code => @scheme_master.securitycode, :bench_mark_index_name => "Crisil Liquid Fund Index"
    @navcp = create :navcp, :security_code => @scheme_master.securitycode
    @mf_objective = create :mf_objective, :securitycode => @scheme_master.securitycode
    @mf_dividend_detail = create :mf_dividend_detail, :securitycode => @scheme_master.securitycode
    @nav_category_detail = create :nav_category_detail, :scheme_class_code => @scheme_master.scheme_class_code
    @mf_scheme_wise_portfolio = create :mf_scheme_wise_portfolio, :security_code => @scheme_master.securitycode
  end

  pending "should display all the required fields for a mutual fund summary" do
    visit scheme_summary_mutual_fund_path(scheme_master.scheme_name)
    page.should have_content scheme_master.scheme_name
    page.should have_content fund_master.company_name
    page.should have_content nav_master.bench_mark_index_name
    page.should have_content scheme_master.scheme_class_description
    page.should have_content scheme_master.scheme_plan_description
    page.should have_content scheme_master.scheme_type_description
    page.should have_content mf_objective.objective
    page.should have_content mf_dividend_detail.percentage
    page.should have_content mf_dividend_detail.dividend_date
    page.should have_content navcp.percentage_change
    page.should have_content navcp.prev3_months_per
    page.should have_content navcp.prev9_months_per
    page.should have_content navcp.prev2_year_per
    page.should have_content nav_category_detail.one_day_return
    page.should have_content nav_category_detail.one_month_return
    page.should have_content nav_category_detail.six_months_return
    page.should have_content nav_category_detail.one_year_return
    page.should have_content nav_category_detail.three_year_return
  end
end

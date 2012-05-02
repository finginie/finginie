require 'spec_helper'

describe "MutualFunds" do
  before(:each) do
    @scheme = create :scheme, :objective => "Objective", :bench_mark_index_name => "Crisil Liquid Fund Index"
    @amc =  create :asset_management_company, :company_code => @scheme.company_code, :company_name => "HDFC Mutual Fund"
    @mf_dividend_detail = create :mf_dividend_detail, :securitycode => @scheme.securitycode
    @nav_category_detail = create :net_asset_value_category, :scheme_class_code => @scheme.scheme_class_code
    @mf_scheme_wise_portfolio = create :mf_scheme_wise_portfolio, :security_code => @scheme.securitycode
  end
  let(:mutual_fund) { create :mutual_fund }
  subject { mutual_fund }

  it { should validate_uniqueness_of :name }

  it "should display all the required fields for a mutual fund summary" do
    visit scheme_summary_mutual_fund_path(@scheme.scheme_name)
    page.should have_content @scheme.scheme_name
    page.should have_content @amc.company_name
    page.should have_content @scheme.bench_mark_index_name
    page.should have_content @scheme.scheme_class_description
    page.should have_content @scheme.scheme_plan_description
    page.should have_content @scheme.scheme_type_description
    page.should have_content @scheme.objective
    page.should have_content @mf_dividend_detail.percentage.round(2)
    page.should have_content @mf_dividend_detail.dividend_date
  end

  it "should have search in the scheme page", :js => true do
    visit scheme_summary_mutual_fund_path(@scheme.scheme_name)
    page.execute_script %Q{ $('#scheme_scheme_name').val("#{@scheme.scheme_name[0..5]}").keydown(); }

    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{@scheme.scheme_name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{@scheme.scheme_name}")').trigger('mouseenter').click(); }
    page.current_path.should eq scheme_summary_mutual_fund_path(@scheme.scheme_name)

  end
end

require 'spec_helper'

describe "MutualFunds", :mongoid do
  before(:each) do
    @scheme = create :scheme, :objective => "Objective", :bench_mark_index_name => "Crisil Liquid Fund Index"
    @amc =  create :asset_management_company, :company_code => @scheme.company_code, :company_name => "HDFC Mutual Fund"
    @mf_dividend_detail = create :mf_dividend_detail, :security_code => @scheme.security_code
    @nav_category_detail = create :net_asset_value_category, :scheme_class_code => @scheme.class_code
    @mf_scheme_wise_portfolio = create :mf_scheme_wise_portfolio, :security_code => @scheme.security_code
  end
  let(:mutual_fund) { create :mutual_fund }
  subject { mutual_fund }

  it { should validate_uniqueness_of :name }

  it "should display all the required fields for a mutual fund summary" do
    visit scheme_summary_mutual_fund_path(@scheme.name)
    page.should have_content @scheme.name
    page.should have_content @amc.company_name
    page.should have_content @scheme.bench_mark_index_name
    page.should have_content @scheme.class_description
    page.should have_content @scheme.plan_description
    page.should have_content @scheme.type_description
    page.should have_content @scheme.objective
    page.should have_content @mf_dividend_detail.percentage.round(2)
    page.should have_content @mf_dividend_detail.dividend_date
  end

  it "should have search in the scheme page", :js => true do
    visit scheme_summary_mutual_fund_path(@scheme.name)
    page.execute_script %Q{ $('#scheme_name').val("#{@scheme.name[0..5]}").keydown(); }

    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{@scheme.name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{@scheme.name}")').trigger('mouseenter').click(); }
    page.current_path.should eq scheme_summary_mutual_fund_path(@scheme.name)

  end

  context "#index" do
    it "should have top funds" do
      2.times { |i| create :scheme, :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
        :prev1_month_percent =>  6 * i + 3, :prev_year_percent =>  6 * i + 5, :prev3_year_percent =>  6 * i + 6 }

      visit mutual_funds_path

      expected_content = [
        [ 'scheme-0', '2.0', '1.00', '3.00', '5.00', '6.00' ],
        [ 'scheme-1', '4.0', '6.00', '9.00', '11.00', '12.00' ] ]

      tableish("#top_performers").should include *expected_content
    end

    it "should redirect to scheme summary page when a scheme in Top 10 funds is clicked on" do
      visit mutual_funds_path

      within "#top_performers" do
        click_on @scheme.name
      end
      page.current_path.should eq scheme_summary_mutual_fund_path @scheme.name
    end

    it "should have biggest funds" do
      2.times { |i| create :scheme, :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
        :size => 238.68 + i * 100, :prev_year_percent =>  6 * i + 5  }

      visit mutual_funds_path

      expected_content = [
        [ 'scheme-0', '2.0', '1.00', '238.68', '5.00' ],
        [ 'scheme-1', '4.0', '6.00', '338.68', '11.00' ] ]

      tableish("#biggest_schemes").should include *expected_content
    end
  end

  context "Titles" do
    it "should have title for index page" do
      visit mutual_funds_path
      page.should have_selector("title", :content => I18n.t('mutual_funds.index.title'))
    end

    it "should have title for summary page" do
      visit scheme_summary_mutual_fund_path(@scheme.name)
      page.should have_selector("title", :content => I18n.t('mutual_funds.scheme_summary.title'))
    end

    it "should have title for returns page" do
      visit scheme_returns_mutual_fund_path(@scheme.name)
      page.should have_selector("title", :content => I18n.t('mutual_funds.scheme_returns.title'))
    end

    it "should have title for asset allocation page" do
      visit asset_allocation_mutual_fund_path(@scheme.name)
      page.should have_selector("title", :content => I18n.t('mutual_funds.asset_allocation.title'))
    end

    it "should have title for sectoral allocation page" do
      visit sectoral_allocation_mutual_fund_path(@scheme.name)
      page.should have_selector("title", :content => I18n.t('mutual_funds.sectoral_allocation.title'))
    end

    it "should have title for top holdings page" do
      visit top_holdings_mutual_fund_path(@scheme.name)
      page.should have_selector("title", :content => I18n.t('mutual_funds.top_holdings.title'))
    end

    it "should have title for detailed holdings page" do
      visit detailed_holdings_mutual_fund_path(@scheme.name)
      page.should have_selector("title", :content => I18n.t('mutual_funds.details.title'))
    end
  end
end

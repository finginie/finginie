require 'spec_helper'

describe "MutualFunds", :mongoid do
  before(:each) do
    @scheme = create :'data_provider/scheme', :objective => "Objective", :bench_mark_index_name => "Crisil Liquid Fund Index"
    @amc =  create :'data_provider/asset_management_company', :company_code => @scheme.company_code, :company_name => "HDFC Mutual Fund"
    @mf_dividend_detail = create :'data_provider/mf_dividend_detail', :security_code => @scheme.security_code
    @nav_category_detail = create :'data_provider/net_asset_value_category', :scheme_class_code => @scheme.class_code
    @mf_scheme_wise_portfolio = create :'data_provider/mf_scheme_wise_portfolio', :security_code => @scheme.security_code
  end
  let(:mutual_fund) { create :mutual_fund }
  subject { mutual_fund }

  it { should validate_uniqueness_of :name }

  it "should display all the required fields for a mutual fund summary" do
    visit mutual_fund_path(@scheme)
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
    visit mutual_fund_path(@scheme)
    page.execute_script %Q{ $('[data-autocomplete-source]').val("#{@scheme.name[0..5]}").keydown(); }

    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{@scheme.name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{@scheme.name}")').trigger('mouseenter').click(); }
    page.current_path.should eq mutual_fund_path(@scheme)

  end

  it "should display only active items in search", :js => true do
    inactive_scheme = create :'data_provider/scheme', :delete_flag => "True"
    visit mutual_fund_path(@scheme)
    page.execute_script %Q{ $('[data-autocomplete-source]').val("#{@scheme.name[0..5]}").keydown(); }

    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{@scheme.name}')") }
    page.should_not have_selector(".ui-menu-item a:contains('#{inactive_scheme.name}')")

  end

  context "#index" do
    it "should have top funds" do
      2.times { |i| create :'data_provider/scheme', :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
        :prev1_month_percent =>  6 * i + 3, :prev_year_percent =>  6 * i + 5, :prev3_year_percent =>  6 * i + 6 }

      visit mutual_funds_path

      expected_content = [
        [ 'scheme-0', '2.00', '1.00', '3.00', '5.00', '6.00' ],
        [ 'scheme-1', '4.00', '6.00', '9.00', '11.00', '12.00' ] ]

      tableish("#top_performers").should include *expected_content
    end

    it "should only have active schemes in top funds and biggest funds" do
      inactive_scheme = create :'data_provider/scheme', :delete_flag => "True"
      visit mutual_funds_path

      within "#top_performers" do
        page.should_not have_link inactive_scheme.name
      end

      within "#biggest_schemes" do
        page.should_not have_link inactive_scheme.name
      end

    end

    it "should redirect to scheme summary page when a scheme in Top 10 funds is clicked on" do
      visit mutual_funds_path

      within "#top_performers" do
        click_on @scheme.name
      end
      page.current_path.should eq mutual_fund_path @scheme
    end

    it "should have biggest funds" do
      2.times { |i| create :'data_provider/scheme', :name => "scheme-#{i}",:nav_amount => 2 * i + 2, :percentage_change => 5 * i + 1,
        :size => 238.68 + i * 100, :prev_year_percent =>  6 * i + 5  }

      visit mutual_funds_path

      expected_content = [
        [ 'scheme-0', '2.00', '1.00', '238.68', '5.00' ],
        [ 'scheme-1', '4.00', '6.00', '338.68', '11.00' ] ]

      tableish("#biggest_schemes").should include *expected_content
    end

  end

  context "Titles" do
    it "should have title for index page" do
      visit mutual_funds_path
      page.should have_selector("title", :content => I18n.t('mutual_funds.index.title'))
    end

    it "should have title for summary page" do
      visit mutual_fund_path(@scheme)
      page.should have_selector("title", :content => I18n.t('mutual_funds.show.title'))
    end

    it "should have title for returns page" do
      visit scheme_returns_mutual_fund_path(@scheme)
      page.should have_selector("title", :content => I18n.t('mutual_funds.scheme_returns.title'))
    end

    it "should have title for asset allocation page" do
      visit asset_allocation_mutual_fund_path(@scheme)
      page.should have_selector("title", :content => I18n.t('mutual_funds.asset_allocation.title'))
    end

    it "should have title for sectoral allocation page" do
      visit sectoral_allocation_mutual_fund_path(@scheme)
      page.should have_selector("title", :content => I18n.t('mutual_funds.sectoral_allocation.title'))
    end

    it "should have title for top holdings page" do
      visit top_holdings_mutual_fund_path(@scheme)
      page.should have_selector("title", :content => I18n.t('mutual_funds.top_holdings.title'))
    end

    it "should have title for detailed holdings page" do
      visit detailed_holdings_mutual_fund_path(@scheme)
      page.should have_selector("title", :content => I18n.t('mutual_funds.details.title'))
    end
  end
end

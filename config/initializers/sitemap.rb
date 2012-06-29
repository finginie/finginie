DynamicSitemaps::Sitemap.draw do
  # default per_page is 50.000 which is the specified maximum.
  per_page 20000

  url root_url, :change_freq => 'daily', :priority => 1
  # top navigation links
  url main_app.page_url('investment_education'), :change_freq => 'daily', :priority => '0.8'
  url main_app.page_url('blog/index'), :change_freq => 'daily', :priority => '0.8'
  url main_app.page_url('trade'), :change_freq => 'daily', :priority => '0.8'
  url main_app.comprehensive_risk_profiler_url, :change_freq => 'daily', :priority => '0.8'
  url main_app.portfolios_url, :change_freq => 'daily', :priority => '0.9'
  url main_app.fixed_deposits_url, :change_freq => 'daily', :priority => '0.8'
  url main_app.stocks_url, :change_freq => 'daily', :priority => '0.8'
  url main_app.mutual_funds_url, :change_freq => 'daily', :priority => '0.8'
  url personal_financial_tools.personal_financial_tools_url, :change_freq => 'daily', :priority => '0.8'

  # static pages
  Dir.glob(Rails.root.join('app', 'views', 'pages', '*.haml')).each do |file|
    id = Pathname.new(file).basename(".html.haml").to_s
    url main_app.page_url(id), :change_freq => 'monthly', :priority => '0.3'
  end
  # investment education pages
  Dir.glob(Rails.root.join('app', 'views', 'pages', 'investment_education', '*.haml')).each do |file|
    id = Pathname.new(file).basename(".html.haml").to_s
    url main_app.page_url("investment_education/#{id}"), :change_freq => 'monthly', :priority => '0.5'
  end

  # personal financial tools
  url personal_financial_tools.emi_calculator_url,               :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.fixed_deposit_calculator_url,     :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.recurring_deposit_calculator_url, :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.sip_calculator_url,               :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.monthly_sip_calculator_url,       :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.income_tax_calculator_url,        :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.rate_of_return_calculator_url,    :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.life_insurance_calculator_url,    :change_freq => 'monthly', :priority => '0.5'
  url personal_financial_tools.retirement_calculator_url,        :change_freq => 'monthly', :priority => '0.5'

  # stocks and nested resources
  new_page!
  DataProvider::Scheme.only(:slug).active.each do |scheme|
    url mutual_fund_url(scheme.slug), :change_freq => 'daily', :priority => '0.64'

    url main_app.scheme_returns_mutual_fund_url(scheme.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.top_holdings_mutual_fund_url(scheme.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.detailed_holdings_mutual_fund_url(scheme.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.asset_allocation_mutual_fund_url(scheme.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.sectoral_allocation_mutual_fund_url(scheme.slug), :change_freq => 'daily', :priority => '0.64'

  end

  # mutual funds pages
  new_page!
  DataProvider::Company.only(:slug).all.each do |company|
    url stock_url(company.slug), :change_freq => 'daily', :priority => 0.64

    url main_app.stock_balance_sheet_url(company.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.stock_profit_loss_url(company.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.stock_cash_flow_url(company.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.stock_ratios_url(company.slug), :change_freq => 'daily', :priority => '0.64'
    url main_app.stock_share_holding_url(company.slug), :change_freq => 'daily', :priority => '0.64'
  end

  # autogenerate  :products, :categories,
  #               :last_mod => :updated_at,
  #               :change_freq => 'monthly',
  #               :priority => 0.8

  # new_page!

  # autogenerate  :users,
  #               :last_mod => :updated_at,
  #               :change_freq => lambda { |user| user.very_active? ? 'weekly' : 'monthly' },
  #               :priority => 0.5

end

# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new { |key| "navigation-#{key}" }
  navigation.renderer = LevelTaggedList

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :about_us, 'About us', main_app.page_path('about_us') do |secondary|
      secondary.item :team, 'Management Team', main_app.page_path('team')
      secondary.item :team, 'Research Team', main_app.page_path('research-team')
      secondary.item :careers, 'Careers', main_app.page_path('careers')
      secondary.item :contact_us, 'Contact us', main_app.page_path('contact_us')
      secondary.item :Terms_of_use, 'Terms of use', main_app.page_path('terms_of_use')
    end
    primary.item :investment_education, 'Learn Investing',main_app.page_path('investment_education') do |secondary|
      secondary.item :preparing_to_invest, 'Preparing to Invest' do |tertiary|
        tertiary.item :how_to_invest_successfully, 'How to Invest', main_app.page_path('investment_education/smart-investments')
        tertiary.item :an_overview, 'Types of Investments', main_app.page_path('investment_education/investment-types')
        tertiary.item :investment_trading, 'Investing vs Trading', main_app.page_path('investment_education/investing-trading-shares')
      end
      secondary.item :before_you_invest, 'Before you Invest' do |tertiary|
        tertiary.item :investment_plan, 'Investment Plan', main_app.page_path('investment_education/investment-plan')
        tertiary.item :where_to_invest, 'Where to Invest', main_app.page_path('investment_education/where-to-invest')
        tertiary.item :diversification, 'Diversification', main_app.page_path('investment_education/investment-diversification')
        tertiary.item :planning_your_taxes, 'Planning your Taxes', main_app.page_path('investment_education/tax-planning')
      end
      secondary.item :investment_types, 'Types of Investments' do |tertiary|
        tertiary.item :fixed_deposits, 'Fixed Deposits', main_app.page_path('investment_education/investment-fixed-deposits')
        tertiary.item :gold, 'Gold', main_app.page_path('investment_education/gold-investment')
        tertiary.item :shares, 'Shares', main_app.page_path('investment_education/shares')
        tertiary.item :mutual_funds, 'Mutual Funds and ETFs', main_app.page_path('investment_education/mutual-funds-etf')
        tertiary.item :bonds, 'Bonds', main_app.page_path('investment_education/bonds')
        tertiary.item :life_insurance, 'Life Insurance', main_app.page_path('investment_education/life-insurance-policies')
        tertiary.item :sip, 'Sip', main_app.page_path('investment_education/sip')
      end
      secondary.item :investing_in_shares, 'Investing in Shares' do |tertiary|
        tertiary.item :share_market, 'Share Market', main_app.page_path('investment_education/share-market')
        tertiary.item :fundamental_analysis1, 'Fundamental Analysis', main_app.page_path('investment_education/fundamental-analysis-shares')
        tertiary.item :technical_analysis, 'Technical Analysis', main_app.page_path('investment_education/technical-analysis-shares')
        tertiary.item :banking_sector, 'Banking Sector', main_app.page_path('investment_education/banking-sector-shares')
        tertiary.item :information_technology, 'IT Sector', main_app.page_path('investment_education/it-sector')
      end

      secondary.item :advanced_investments, 'Further Reading' do |tertiary|
        tertiary.item :read_more_articles, 'Articles', main_app.page_path('investment_education/articles')
      end
    end

    primary.item :market_commentary, 'Market Commentary', main_app.page_path('blog/index')

    primary.item :financial_planner, 'Financial Profile', main_app.comprehensive_risk_profiler_path do |secondary|
      secondary.item :edit_comprehensive_risk_profilers, 'Personalized Financial Plan', main_app.edit_comprehensive_risk_profiler_path
      secondary.item :comprehensive_risk_profilers, 'Ideal Asset Allocation', main_app.comprehensive_risk_profiler_path
    end

    primary.item :trade, 'Trade', main_app.page_path('trade')

    primary.item :trade, 'Stock Tips', main_app.page_path('stock-recommendations')

    primary.item :portfolios, 'Portfolio Tracker', main_app.portfolios_path, :highlights_on => :subpath do |secondary|
      if current_user
        current_user.portfolios.each do |portfolio|
          if portfolio.persisted?
            secondary.item "portfolio_#{portfolio.id}".to_sym, portfolio.name do |tertiary|
              tertiary.item :add_transaction,         'Add Transactions',        main_app.add_transaction_portfolio_path(portfolio)
              tertiary.item :details,                 'Current Holdings',        main_app.details_portfolio_path(portfolio)
              tertiary.item :accumulated_profits,     'Profit/Loss',             main_app.accumulated_profits_portfolio_path(portfolio)
              tertiary.item :transactions,            'Historical Transactions', main_app.transactions_portfolio_path(portfolio)
              tertiary.item :show,                    'Assets Breakdown',        main_app.portfolio_path(portfolio)
              tertiary.item :stocks_analysis,         'Stocks Analysis',         main_app.stocks_analysis_portfolio_path(portfolio)
              tertiary.item :mutual_funds_analysis,   'Mutual Funds Analysis',   main_app.mutual_funds_analysis_portfolio_path(portfolio)
              tertiary.item :fixed_deposits_analysis, 'Fixed Deposits Analysis', main_app.fixed_deposits_analysis_portfolio_path(portfolio)
            end
          end
        end
      end
    end

    primary.item :fixed_deposit, 'Fixed Deposits', main_app.fixed_deposits_path

    primary.item :stocks, 'Shares', main_app.stocks_path, :highlights_on => :subpath do |secondary|
      if @company
        secondary.item :stock,           "#{@company.name}",main_app.stock_path(@company), :highlights_on => :subpath do |tertiary|
          tertiary.item :balance_sheet,  'Balance Sheet',         main_app.stock_balance_sheet_path(@company)
          tertiary.item :profit_loss,    'Income Statement',      main_app.stock_profit_loss_path(@company)
          tertiary.item :cash_flow,      'Cash Flow',             main_app.stock_cash_flow_path(@company)
          tertiary.item :ratios,         'Ratios',                main_app.stock_ratios_path(@company)
          tertiary.item :share_holding,  'Share Holding Pattern', main_app.stock_share_holding_path(@company)
        end
      end
    end

    primary.item :mutual_funds, 'Mutual Funds', main_app.mutual_funds_path, :highlights_on => :subpath do |secondary|
      if @nav_category_detail.try(:scheme_class_description)
        secondary.item :mutual_fund_category, @nav_category_detail.scheme_class_description, main_app.mutual_fund_category_path(params[:id])
      end
      if @scheme.try(:name)
        secondary.item :scheme_summary, 'Scheme Summary', main_app.mutual_fund_path(@scheme)
        secondary.item :scheme_returns, 'Scheme Returns', main_app.scheme_returns_mutual_fund_path(@scheme)
        secondary.item :top_holdings,   'Top Holdings', main_app.top_holdings_mutual_fund_path(@scheme)
        secondary.item :detailed_holdings, 'Detailed Holdings', main_app.detailed_holdings_mutual_fund_path(@scheme)
        secondary.item :asset_allocation, 'Asset Allocation', main_app.asset_allocation_mutual_fund_path(@scheme)
        secondary.item :sectoral_allocation, 'Sectoral Allocation', main_app.sectoral_allocation_mutual_fund_path(@scheme)
      end
    end

    primary.item :personal_financial_tools, 'Financial Tools', personal_financial_tools.personal_financial_tools_path do |secondary|
      secondary.item :emi_calculator, 'EMI Calculator', personal_financial_tools.emi_calculator_path
      secondary.item :fixed_deposit_calculator,'Fixed Deposit Calculator', personal_financial_tools.fixed_deposit_calculator_path
      secondary.item :recurring_deposit_calculator, 'Recurring Deposit Calculator', personal_financial_tools.recurring_deposit_calculator_path
      secondary.item :sip_calculator, 'SIP Calculator', personal_financial_tools.sip_calculator_path
      secondary.item :monthly_sip_calculator, 'Monthly SIP Calculator', personal_financial_tools.monthly_sip_calculator_path
      secondary.item :income_tax_calculator, 'Income Tax Calculator', personal_financial_tools.income_tax_calculator_path
      secondary.item :rate_of_return_calculator, 'Rate of Return Calculator', personal_financial_tools.rate_of_return_calculator_path
      secondary.item :life_insurance_calculator, 'Life Insurance Calculator', personal_financial_tools.life_insurance_calculator_path
      secondary.item :retirement_calculator, 'Retirement Calculator', personal_financial_tools.retirement_calculator_path
    end
  end
end

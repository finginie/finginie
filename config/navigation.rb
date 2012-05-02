# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new { |key| "navigation-#{key}" }
  navigation.renderer = LevelTaggedList

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :about_us, 'About us', main_app.page_path('about_us') do |secondary|
      secondary.item :team, 'Team', main_app.page_path('team')
      secondary.item :careers, 'Careers', main_app.page_path('careers')
      secondary.item :contact_us, 'Contact us', main_app.page_path('contact_us')
    end
    primary.item :investment_education, 'Learn Investing',main_app.page_path('investment_education') do |secondary|
      secondary.item :investment_concepts, 'Investment Concepts' do |tertiary|
        tertiary.item :risk_and_return, 'Risk and Return', main_app.page_path('investment_education/risk_and_return')
        tertiary.item :time_value_of_money, 'Time Value of Money', main_app.page_path('investment_education/time_value_of_money')
        tertiary.item :diversification, 'Diversification', main_app.page_path('investment_education/diversification')
        tertiary.item :investment_trading, 'Investing vs Trading', main_app.page_path('investment_education/investment_trading')
      end
      secondary.item :investment_process, 'Investment Process' do |tertiary|
        tertiary.item :analyzing_needs, 'Analyzing your needs', main_app.page_path('investment_education/analyzing_needs')
        tertiary.item :investment_plan, 'Investment Plan', main_app.page_path('investment_education/investment_plan')
        tertiary.item:asset_allocation, 'Asset Allocation', main_app.page_path('investment_education/asset_allocation')
        tertiary.item :choosing_investments, 'Choosing Investments', main_app.page_path('investment_education/choosing_investments')
        tertiary.item :start_investing, 'Start investing', main_app.page_path('investment_education/start_investing')
        tertiary.item :track_investment, 'Tracking your investments', main_app.page_path('investment_education/track_investment')
        tertiary.item :risk_management, 'Risk Management', main_app.page_path('investment_education/risk_management')
        tertiary.item :reduce_taxes, 'Reducing your taxes', main_app.page_path('investment_education/reduce_taxes')
      end
      secondary.item :investment_analysis, 'Investment Analysis' do |tertiary|
        tertiary.item :fundamental_analysis1, 'Fundamental Analysis', main_app.page_path('investment_education/fundamental_analysis1')
        tertiary.item :fundamental_analysis2, 'Fundamental Analysis II', main_app.page_path('investment_education/fundamental_analysis2')
        tertiary.item :technical_analysis, 'Technical Analysis', main_app.page_path('investment_education/technical_analysis')
      end
      secondary.item :investment_types, 'Types of Investments' do |tertiary|
        tertiary.item :overview, 'Overview', main_app.page_path('investment_education/overview')
        tertiary.item :cash_equivalents, 'Cash Equivalents', main_app.page_path('investment_education/cash_equivalents')
        tertiary.item :bonds, 'Bonds', main_app.page_path('investment_education/bonds')
        tertiary.item :stocks1, 'Stocks', main_app.page_path('investment_education/stocks1')
        tertiary.item :stocks2, 'Stocks II', main_app.page_path('investment_education/stocks2')
        tertiary.item :mutual_funds, 'Mutual Funds', main_app.page_path('investment_education/mutual_funds')
        tertiary.item :exchange_traded, 'Exchange Traded Funds', main_app.page_path('investment_education/exchange_traded')
        tertiary.item :commodities, 'Commodities', main_app.page_path('investment_education/commodities')
        tertiary.item :insurance_products, 'Insurance Products', main_app.page_path('investment_education/insurance_products')
        tertiary.item :real_estate_investment, 'Real estate Investments', main_app.page_path('investment_education/real_estate_investment')
      end

      secondary.item :advanced_investments, 'Advanced Investments' do |tertiary|
        tertiary.item :foreign_exchange1, 'Foreign Exchange', main_app.page_path('investment_education/foreign_exchange1')
        tertiary.item :foreign_exchange2, 'Foreign Exchange II', main_app.page_path('investment_education/foreign_exchange2')
        tertiary.item :forwards, 'Forwards', main_app.page_path('investment_education/forwards')
        tertiary.item :futures1, 'Futures', main_app.page_path('investment_education/futures1')
        tertiary.item :futures2, 'Futures II', main_app.page_path('investment_education/futures2')
        tertiary.item :options1, 'Options', main_app.page_path('investment_education/options1')
        tertiary.item :options2, 'Options II', main_app.page_path('investment_education/options2')
      end

      secondary.item :jargon_demystified, 'Jargon Demystified' do |tertiary|
        tertiary.item :glossary, 'Glossary', main_app.page_path('investment_education/glossary')
      end
    end

    primary.item :financial_planner, 'Financial Profile', main_app.edit_comprehensive_risk_profiler_path do |secondary|
      secondary.item :edit_comprehensive_risk_profilers, 'Personalized Financial Plan', main_app.edit_comprehensive_risk_profiler_path
      secondary.item :comprehensive_risk_profilers, 'Ideal Asset Allocation', main_app.comprehensive_risk_profiler_path
    end

    primary.item :portfolios, 'My Investments', main_app.portfolios_path, :highlights_on => :subpath do |secondary|
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

    primary.item :stocks, 'Stocks', main_app.stocks_path, :highlights_on => :subpath do |secondary|
      if @company
        secondary.item :stock,           "#{@company.company_name}",main_app.stock_path(@company.company_code), :highlights_on => :subpath do |tertiary|
          tertiary.item :balance_sheet,  'Balance Sheet',         main_app.stock_balance_sheet_path(@company.company_code)
          tertiary.item :profit_loss,    'Income Statement',      main_app.stock_profit_loss_path(@company.company_code)
          tertiary.item :cash_flow,      'Cash Flow',             main_app.stock_cash_flow_path(@company.company_code)
          tertiary.item :ratios,         'Ratios',                main_app.stock_ratios_path(@company.company_code)
          tertiary.item :share_holding,  'Share Holding Pattern', main_app.stock_share_holding_path(@company.company_code)
        end
      end
    end

    primary.item :mutual_funds, 'Mutual Funds', main_app.mutual_funds_path, :highlights_on => :subpath do |secondary|
      if @nav_category_detail.try(:scheme_class_description)
        secondary.item :mutual_fund_category, @nav_category_detail.scheme_class_description, main_app.mutual_fund_category_path(params[:id])
      end
      if @scheme.try(:scheme_name)
        secondary.item :scheme_summary, 'Scheme Summary', main_app.scheme_summary_mutual_fund_path(@scheme.scheme_name)
        secondary.item :scheme_returns, 'Scheme Returns', main_app.scheme_returns_mutual_fund_path(@scheme.scheme_name)
        secondary.item :top_holdings,   'Top Holdings', main_app.top_holdings_mutual_fund_path(@scheme.scheme_name)
        secondary.item :detailed_holdings, 'Detailed Holdings', main_app.detailed_holdings_mutual_fund_path(@scheme.scheme_name)
        secondary.item :asset_allocation, 'Asset Allocation', main_app.asset_allocation_mutual_fund_path(@scheme.scheme_name)
        secondary.item :sectoral_allocation, 'Sectoral Allocation', main_app.sectoral_allocation_mutual_fund_path(@scheme.scheme_name)
      end
    end

    primary.item :personal_financial_tools, 'Financial Tools', personal_financial_tools.personal_financial_tools_path do |secondary|
      secondary.item :emi_calculators, 'EMI Calculator', personal_financial_tools.emi_calculators_path
      secondary.item :fixed_deposit_calculators,'Fixed Deposit Calculators', personal_financial_tools.fixed_deposit_calculators_path
      secondary.item :recurring_deposit_calculator, 'Recurring Deposit Calculator', personal_financial_tools.recurring_deposit_calculator_path
      secondary.item :sip_calculator, 'SIP Calculator', personal_financial_tools.sip_calculator_path
      secondary.item :monthly_sip_calculator, 'Monthly SIP Calculator', personal_financial_tools.monthly_sip_calculator_path
      secondary.item :income_tax_calculator, 'Income Tax Calculator', personal_financial_tools.income_tax_calculator_path
      secondary.item :rate_of_return_calculator, 'Rate of Return Calculator', personal_financial_tools.rate_of_return_calculator_path
      secondary.item :life_insurance_calculators, 'Life Insurance Calculators', personal_financial_tools.life_insurance_calculators_path
      secondary.item :retirement_corpus_calculator, 'Retirement Corpus Calculator', personal_financial_tools.retirement_corpus_calculator_path
    end
  end
end

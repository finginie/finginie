# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Define the primary navigation
  navigation.items do |primary|
    primary.item :home, 'Home', root_path do |secondary|
      # secondary.item :coming_soon, 'Coming Soon', page_path('coming_soon')
      # secondary.item :about_us, 'About Us', page_path('about_us')
      # secondary.item :team, 'Team', page_path('team')
      # secondary.item :terms_of_use, 'Terms of Use', page_path('terms_of_use')
      # secondary.item :privacy_policy, 'Privacy Policy', page_path('privacy_policy')
      # secondary.item :faq, 'FAQ', page_path('faq')
      # secondary.item :careers, 'Careers', page_path('careers')
      # secondary.item :contact_us, 'Contact Us', page_path('contact_us')
    end

    primary.item :dashboard, 'DashBoard', root_path do |secondary|
      secondary.item :stocks, 'Stock Markets', stocks_path
      secondary.item :portfolios, 'Portfolios', portfolios_path
    end

    # %section
    # %h1= link_to t('financial_planner_risk_profiler'), financial_planner_risk_profiler_path
    # %ul
    #   - Quiz.all.each do |quiz|
    #     %li= link_to quiz.name, financial_planner_risk_profiler_path(:id => quiz.slug)

    primary.item :personal_financial_tools, 'Personal Financial Tools', personal_financial_tools_path do |secondary|
      secondary.item :emi_calculators, 'EMI Calculator', emi_calculators_path
      secondary.item :fixed_deposit_calculators,'Fixed Deposit Calculators', fixed_deposit_calculators_path
      secondary.item :recurring_deposit_calculator, 'Recurring Deposit Calculator', recurring_deposit_calculator_path
      secondary.item :sip_calculator, 'SIP Calculator', sip_calculator_path
      secondary.item :monthly_sip_calculator, 'Monthly SIP Calculator', monthly_sip_calculator_path
      secondary.item :income_tax_calculator, 'Income Tax Calculator', income_tax_calculator_path
      secondary.item :rate_of_return_calculator, 'Rate of Return Calculator', rate_of_return_calculator_path
      secondary.item :life_insurance_calculators, 'Life Insurance Calculators', life_insurance_calculators_path
      secondary.item :retirement_corpus_calculator, 'Retirement Corpus Calculator', retirement_corpus_calculator_path
    end

    primary.item :investment_education, 'Investment Education',page_path('investment_education') do |secondary|
      secondary.item:investment_concepts, 'Investment Concepts',page_path('investment_education/risk_and_return') do |tertiary|
        tertiary.item:risk_and_return, 'Risk and Return', page_path('investment_education/risk_and_return')
        tertiary.item:time_value_of_money, 'Time Value of Money', page_path('investment_education/time_value_of_money')
        tertiary.item:diversification, 'Diversification', page_path('investment_education/diversification')
        tertiary.item:investment_trading, 'Investing vs Trading', page_path('investment_education/investment_trading')
      end
      secondary.item:investment_process, 'Investment Process', page_path('investment_education/analyzing_needs') do |tertiary|
        tertiary.item:analyzing_needs, 'Analyzing your needs', page_path('investment_education/analyzing_needs')
        tertiary.item:investment_plan, 'Investment Plan', page_path('investment_education/investment_plan')
        tertiary.item:asset_allocation, 'Asset Allocation', page_path('Asset Allocation')
        tertiary.item:choosing_investments, 'Choosing Investments', page_path('investment_education/choosing_investments')
        tertiary.item:start_investing, 'Start investing', page_path('investment_education/start_investing')
        tertiary.item:track_investment, 'Tracking your investments', page_path('investment_education/track_investment')
        tertiary.item:risk_management, 'Risk Management', page_path('investment_education/risk_management')
        tertiary.item:reduce_taxes, 'Reducing your taxes', page_path('investment_education/reduce_taxes')
      end
      secondary.item:investment_analysis, 'Investment Analysis', page_path('investment_education/fundamental_analysis1') do |tertiary|
        tertiary.item:fundamental_analysis1, 'Fundamental Analysis', page_path('investment_education/fundamental_analysis1')
        tertiary.item:fundamental_analysis2, 'Fundamental Analysis II', page_path('investment_education/fundamental_analysis2')
        tertiary.item:technical_analysis, 'Technical Analysis', page_path('investment_education/technical_analysis')
      end
      secondary.item:investment_types, 'Types of Investments', page_path('investment_education/cash_equivalents') do |tertiary|
        tertiary.item:cash_equivalents, 'Cash Equivalents', page_path('investment_education/cash_equivalents')
        tertiary.item:bonds, 'Bonds', page_path('investment_education/bonds')
        tertiary.item:stocks1, 'Stocks', page_path('investment_education/stocks1')
        tertiary.item:stocks2, 'Stocks II', page_path('investment_education/stocks2')
        tertiary.item:mutual_funds, 'Mutual Funds', page_path('investment_education/mutual_funds')
        tertiary.item:exchange_traded, 'Exchange Traded Funds', page_path('investment_education/exchange_traded')
        tertiary.item:commodities, 'Commodities', page_path('investment_education/commodities')
        tertiary.item:insurance_products, 'Insurance Products', page_path('investment_education/insurance_products')
        tertiary.item:real_estate_investment, 'Real estate Investments', page_path('investment_education/real_estate_investment')
      end
      secondary.item:advanced_investments, 'Advances Investments', page_path('investment_education/foreign_exchange1') do |tertiary|
        tertiary.item:foreign_exchange1, 'Foreign Exchange', page_path('investment_education/foreign_exchange1')
        tertiary.item:foreign_exchange2, 'Foreign Exchange II', page_path('investment_education/foreign_exchange2')
        tertiary.item:forwards, 'Forwards', page_path('investment_education/forwards')
        tertiary.item:futures1, 'Futures', page_path('investment_education/futures1')
        tertiary.item:futures2, 'Futures II', page_path('investment_education/futures2')
        tertiary.item:options1, 'Options', page_path('investment_education/options1')
        tertiary.item:options2, 'Options II', page_path('investment_education/options2')
      end
      secondary.item:jargon_demystified, 'Jargon Demystified', page_path('investment_education/glossary') do |tertiary|
        tertiary.item:glossary, 'Glossary', page_path('investment_education/glossary')
      end
    end
  end
end

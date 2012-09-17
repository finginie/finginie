class IdealInvestmentMixDecorator < ApplicationDecorator
  decorates :ideal_investment_mix

  def investment_message
    h.content_tag :div, :class => 'alert alert-notice' do
      if investment_amount.to_f > IdealInvestmentMix::MINIMUM_INVESTMENT.to_f
        I18n.t('display_initial_investment', :amount => investment_amount.to_s)
      else
        I18n.t('ideal_investments.show.too_low_investment')
      end
    end
  end

  def draw_asset_tables
    FinancialPlanner::ASSET_CLASSES.inject(ActiveSupport::SafeBuffer.new) do |result, asset_class|
      result << draw_table_for(asset_class)
    end
  end

  def draw_asset_chart
    h.gchart(:data => security_mix, title: 'Ideal Investments', chart_type: 'Pie')
  end

  def draw_top_elss_table
    elss_header + elss_table
  end

  private
  def elss_table
    elss_table_hsh = {
      :class => %w(table table-striped table-bordered),
      :data => { :role => 'top_elss_funds' }
    }

    h.content_tag(:table, elss_table_hsh) do
      elss_table_header + elss_table_body
    end
  end

  def elss_header
    h.content_tag(:p, I18n.t('ideal_investments.show.elss_message'))
  end

  def elss_table_header
    h.content_tag(:tr) do
      h.content_tag(:th, 'Name') + h.content_tag(:th, '3 Yr Return (%)')
    end
  end

  def elss_table_body
    top_elss_funds.limit(5).inject(ActiveSupport::SafeBuffer.new) do |result, fund|
      elss_fund_path = h.mutual_fund_path(DataProvider::Scheme.where(:name => fund.name).first)
      result << h.content_tag(:tr) do
        h.content_tag(:td) { h.link_to(fund.name, elss_fund_path) } +
          h.content_tag(:td, h.number_with_precision(fund.prev3_year_comp_percent))
      end
    end
  end

  def draw_table_for(asset_class)
    investments = send(asset_class)
    if investments.present?
      investment_table = h.content_tag(:table, :class => %w(table table-striped table-bordered), :data => { :role => asset_class } ) do
        table_header + table_body_for(asset_class)
      end

      investment_header(asset_class) + investment_table
    end
  end

  def investment_header(asset_class)
    h.content_tag('h3', I18n.t("ideal_investments.investments.#{asset_class}"))
  end

  def table_header
    h.content_tag(:tr) do
      h.content_tag(:th, 'Name', :class => 'span9')                                 +
      h.content_tag(:th, I18n.t('ideal_investments.amount'), :class => 'span3')     +
      h.content_tag(:th, I18n.t('ideal_investments.percentage'), :class => 'span3')
    end
  end

  def table_body_for(asset_class)
    investments = send(asset_class)
    amount      = send("#{asset_class.singularize}_amount_per_investment")
    percent     = send("#{asset_class.singularize}_percent_per_investment")

    investments.inject(ActiveSupport::SafeBuffer.new) do |result, investment|
      if asset_class == 'fixed_deposits'
        investment_td_value = "Fixed Deposit at #{investment}"
      else
        investment_path = h.mutual_fund_path(DataProvider::Scheme.where(:name => investment).first)
        investment_td_value = h.link_to(investment, investment_path)
      end

      result << h.content_tag(:tr) do
        h.content_tag(:td, investment_td_value) + h.content_tag(:td, amount) + h.content_tag(:td, percent)
      end
    end
  end

  def security_mix
    FinancialPlanner::ASSET_CLASSES.inject([]) do |result, asset_class|
      asset_investments = send(asset_class)
      amount      = send("#{asset_class.singularize}_amount_per_investment")
      result     += asset_investments.map {|investment| [investment, amount] }
    end
  end

end

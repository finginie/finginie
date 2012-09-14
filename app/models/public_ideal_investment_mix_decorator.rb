class PublicIdealInvestmentMixDecorator < IdealInvestmentMixDecorator

  def security_mix
    FinancialPlanner::ASSET_CLASSES.inject([]) do |result, asset_class|
      asset_investments = send(asset_class)
      percent           = send("#{asset_class.singularize}_percent_per_investment").to_f
      result            += asset_investments.map {|investment| [investment, percent] }
    end
  end

  def table_body_for(asset_class)
    investments = send(asset_class)
    percent     = send("#{asset_class.singularize}_percent_per_investment")

    investments.inject(ActiveSupport::SafeBuffer.new) do |result, investment|
      if asset_class == 'fixed_deposits'
        investment_td_value = "Fixed Deposit at #{investment}"
      else
        investment_path = h.mutual_fund_path(DataProvider::Scheme.where(:name => investment).first)
        investment_td_value = h.link_to(investment, investment_path)
      end

      result << h.content_tag(:tr) do
        h.content_tag(:td, investment_td_value) + h.content_tag(:td, percent)
      end
    end
  end

  def table_header
    h.content_tag(:tr) do
      h.content_tag(:th, 'Name', :class => 'span9') +
      h.content_tag(:th, I18n.t('ideal_investments.percentage'), :class => 'span3')
    end
  end
end
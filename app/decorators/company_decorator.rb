class CompanyDecorator < ApplicationDecorator
  decorates :company

  FIELDS_TO_ROUND = [ 'last_traded_price', 'net_change', 'percent_change', 'close_price',
                      'open_price', 'volume', 'high_price', 'low_price', 'eps', 'pe', 'beta',
                      'fifty_two_week_high_price', 'fifty_two_week_low_price' ]

  FIELDS_TO_ROUND.each do |key|                                               ##
    define_method(key.to_sym) do                                              # def key
      model.send(key) ? model.send(key).round(2) : h.t('not_available')       #   key || "N/A"
    end                                                                       # end
  end                                                                         ##

  def share_holding
    ShareHoldingDecorator.decorate(model.share_holding) if model.share_holding
  end
end

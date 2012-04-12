class CompanyDecorator < ApplicationDecorator
  decorates :company

  FIELDS_TO_ROUND = [ 'last_traded_price', 'net_change', 'percent_change', 'close_price',
                      'open_price', 'volume', 'high_price', 'low_price', 'eps', 'pe',
                      'fifty_two_week_high', 'fifty_two_week_low', 'bse_fifty_two_week_high', 'bse_fifty_two_week_low',
                      'bse_last_traded_price', 'bse_net_change', 'bse_percent_change', 'bse_close_price',
                      'bse_open_price', 'bse_volume', 'bse_high_price', 'bse_low_price',
                      'price_to_book_value', 'market_capitalization', 'book_value', 'face_value', 'dividend_yield']

  FIELDS_TO_ROUND.each do |key|                                               ##
    define_method(key.to_sym) do                                              # def key
      model.send(key) ? model.send(key).round(2) : h.t('not_available')       #   key || "N/A"
    end                                                                       # end
  end                                                                         ##

  def share_holding
    ShareHoldingDecorator.decorate(model.share_holding) if model.share_holding
  end
end

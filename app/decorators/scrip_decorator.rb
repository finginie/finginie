class ScripDecorator < ApplicationDecorator
  decorates :nse_scrip
  decorates :bse_scrip

  FIELDS_TO_ROUND = [ :last_traded_price, :open_price, :high_price, :close_price, :low_price, :volume, :net_change, :percent_change ]

  FIELDS_TO_NA = [ :time ]

  (FIELDS_TO_NA + FIELDS_TO_ROUND).each do |key|                                                              ##
    define_method(key.to_sym) do                                                                              # def key
      return h.t('not_available') unless model.send(key)                                                      #   return "N/A"
      FIELDS_TO_ROUND.include?(key) ?  model.send(key).round(2) : model.send(key)                             #   key.round(2) if key
    end                                                                                                       # end
  end                                                                                                         ##


end

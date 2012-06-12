class ScripDecorator < ApplicationDecorator
  decorates :'data_provider/nse_scrip'
  decorates :'data_provider/bse_scrip'

  FIELDS_TO_ROUND = [ :last_traded_price, :open_price, :high_price, :close_price, :low_price, :net_change, :percent_change ]

  FIELDS_TO_NA = [ :time ]

  (FIELDS_TO_NA + FIELDS_TO_ROUND).each do |key|                                                              ##
    define_method(key.to_sym) do                                                                              # def key
      return h.t('not_available') unless model.send(key)                                                      #   return "N/A"
      FIELDS_TO_ROUND.include?(key) ?  model.send(key).round(2) : model.send(key)                             #   key.round(2) if key
    end                                                                                                       # end
  end                                                                                                         ##

  def volume
    model.volume ? h.number_to_indian_currency(model.volume.round, 0) : h.t('not_available')
  end
end

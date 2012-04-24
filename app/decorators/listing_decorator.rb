class ListingDecorator < ApplicationDecorator
  decorates :listing

  FIELDS_TO_ROUND = [ :fifty_two_week_high, :fifty_two_week_low ]

  FIELDS_TO_NA = [ :high_date, :low_date ]

  (FIELDS_TO_NA + FIELDS_TO_ROUND).each do |key|                                                              ##
    define_method(key.to_sym) do                                                                              # def key
      return h.t('not_available') unless model.send(key)                                                      #   return "N/A"
      FIELDS_TO_ROUND.include?(key) ?  model.send(key).round(2) : model.send(key)                             #   key.round(2) if key
    end                                                                                                       # end
  end                                                                                                         ##

end

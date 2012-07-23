class ScripDecorator < ApplicationDecorator
  decorates :'data_provider/nse_scrip'
  decorates :'data_provider/bse_scrip'

  FIELDS_TO_NA = [ :time, :last_traded_price, :open_price, :high_price, :close_price, :low_price, :net_change, :percent_change ]
  FIELDS_TO_COLORIZE = [ :percent_change]

  FIELDS_TO_NA.each do |key|                    ##
    define_method(key) do                       # def key
      model.send(key) || h.t('not_available')   #   key || "N/A"
    end                                         # end
  end                                           ##

  FIELDS_TO_COLORIZE.each do |key|
    define_method("#{key}_with_colorize".to_sym) do                         # def key_with_colorize
      if model.send(key)                                                    # if model.send(key)
        h.rg_colorize self.send("#{key}_without_colorize"), model.send(key) #
      else
        self.send("#{key}_without_colorize")
      end
    end                                         # end
    alias_method_chain key, :colorize
  end

  def volume
    model.volume ? h.number_to_indian_format(model.volume.round, 0) : h.t('not_available')
  end
end

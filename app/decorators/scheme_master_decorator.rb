class SchemeMasterDecorator < ApplicationDecorator
  decorates :scheme_master

  FIELDS_TO_ROUND = [ 'percentage', 'nav_amount', 'percentage_change', 'dividend_percentage', 'day_change' ]
  def sip
    if model.sip == "True"
      "Yes"
    else
      "No"
    end
  end

  def entry_load
    model.entry_load || "NA"
  end

  def exit_load
    model.exit_load || "NA"
  end

  FIELDS_TO_ROUND.each do |key|
    define_method(key.to_sym) do
      model.send(key.to_sym) ? model.send(key.to_sym).round(2).to_f : "NA"
    end
  end

end

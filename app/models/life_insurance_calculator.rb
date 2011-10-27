class LifeInsuranceCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  class Dependent
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :years, :expense, :_destroy

    def initialize(attributes={})
      @years = (attributes[:years] || 0).to_i
      @expense = (attributes[:expense] || 0.0).to_f
    end

    def persisted?
      false
    end
  end

  def self.float(attr, default_value)
    define_method(attr) do
      instance_variable_set "@#{attr}", instance_variable_get("@#{attr}") || default_value
    end

    define_method("#{attr}=") do |value|
      instance_variable_set "@#{attr}", value.to_f
    end
  end


  [:existing_life_insurance, :existing_provident_fund, :total_outstanding_liabilities,
    :total_assets, :desired_value_of_bequeathed_estate, :family_income
  ].each { |attr| float(attr, 0) }
  attr_accessor :dependents

  def initialize(attributes)
    attributes = {
      :existing_life_insurance => 0,
      :existing_provident_fund => 0,
      :total_outstanding_liabilities => 0,
      :total_assets => 0,
      :desired_value_of_bequeathed_estate => 0,
      :family_income => 0,
      :dependents => []
    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def dependents_attributes=(attributes)
    attributes.each { |k,v| dependents << Dependent.new(v) unless v[:_destroy] == "1" }
  end

  def persisted?
    false
  end

  DISCOUNT_RATE = 1 + 10.0/100

  def extra_insurance_required
    [ one_off_expenses + net_pv - existing_life_insurance, 0].max.round
  end

  def present_value_of(price, tenure)
    price * ( DISCOUNT_RATE ** tenure - 1) / ( DISCOUNT_RATE ** tenure * ( DISCOUNT_RATE - 1 ) )
  end

  def dependent_expenses
    dependents.sum {|d| present_value_of(d.expense, d.years) }
  end

  def net_pv
    [ dependent_expenses - present_value_of(family_income, maximum_tenure_of_dependency) , 0 ].max
  end

  def one_off_expenses
    total_outstanding_liabilities + desired_value_of_bequeathed_estate - total_assets - existing_provident_fund
  end

  def maximum_tenure_of_dependency
    dependents.map{|d| d.years }.max || 0
  end

end

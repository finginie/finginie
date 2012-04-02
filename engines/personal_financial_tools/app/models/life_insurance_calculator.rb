class LifeInsuranceCalculator
  class Dependent
    include ActiveAttr::Model

    attribute :years, :type => Integer
    attribute :expense, :type => Float
    attribute :_destroy, :type => Boolean

    validates :years,   :presence     => true,
                        :numericality => { :greater_than => 0 }
    validates :expense, :presence     => true,
                        :numericality => { :greater_than => 0 }
  end

  include ActiveAttr::Model

  attribute :existing_life_insurance,            :type => Float, :default => 0
  attribute :existing_provident_fund,            :type => Float, :default => 0
  attribute :total_outstanding_liabilities,      :type => Float, :default => 0
  attribute :total_assets,                       :type => Float, :default => 0
  attribute :desired_value_of_bequeathed_estate, :type => Float
  attribute :family_income,                      :type => Float

  validates :existing_life_insurance,             :numericality => { :greater_than_or_equal_to => 0 }
  validates :existing_provident_fund,             :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_outstanding_liabilities,       :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_assets,                        :numericality => { :greater_than_or_equal_to => 0 }
  validates :desired_value_of_bequeathed_estate,  :presence     => true,
                                                  :numericality => { :greater_than => 0 }
  validates :family_income,                       :presence     => true,
                                                  :numericality => { :greater_than => 0 }
  validate :each_dependent

  def dependents
    @dependents ||= []
  end

  def dependents_attributes=(attributes)
    attributes.each { |k,v| dependents << Dependent.new(v) unless v[:_destroy] == "1" }
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

private
  def each_dependent
    dependents.each &:valid?
  end
end

class IncomeTaxCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def self.float(attr, default_value)
    define_method(attr) do
      instance_variable_set "@#{attr}", instance_variable_get("@#{attr}") || default_value
    end

    define_method("#{attr}=") do |value|
      instance_variable_set "@#{attr}", value.to_f
    end
  end

  attr_accessor :sex, :metro
  [ :age, :basic_salary, :house_rent_allowance, :rent, :medical_allowance, :conveyence_allowance,
    :life_insurance_premium, :equity_linked_tax_saving, :pension_fund, :provident_fund,
    :unit_linked_insurance_plan, :national_savings_certificate, :fixed_deposits_in_scheduled_banks,
    :principal_repayment_of_housing_loans, :stamp_duty_and_registration_charges, :education_expenses,
    :infrastructure_bonds, :interest_on_a_housing_loan, :health_insurance_premium,
    :interest_repayment_on_education_loan ].each { |attr| float(attr, 0) }

  def initialize(attributes)
    attributes = {
      :age => 0,
      :sex => 'Male',
      :metro => 'true',
      :basic_salary => 0,
      :house_rent_allowance => 0,
      :rent => 0,
      :medical_allowance => 0,
      :conveyence_allowance => 0,
      :life_insurance_premium => 0,
      :equity_linked_tax_saving => 0,
      :pension_fund => 0,
      :provident_fund => 0,
      :unit_linked_insurance_plan => 0,
      :national_savings_certificate => 0,
      :fixed_deposits_in_scheduled_banks => 0,
      :principal_repayment_of_housing_loans => 0,
      :stamp_duty_and_registration_charges => 0,
      :education_expenses => 0,
      :infrastructure_bonds => 0,
      :interest_on_a_housing_loan => 0,
      :health_insurance_premium => 0,
      :interest_repayment_on_education_loan => 0

    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def senior_citizen
    @senior_citizen ||= case age
      when 0..59
        :normal
      when 60..79
        :senior_citizen
      else
        :very_senior_citizen
    end
  end

  # Slabs gives you various slab amounts and their tax rates for various users
  # slabs[sex][senior_citizen]
  def slabs(sex, senior_citizen)
    reference_slabs = {
        0  => [0,      180000],
        10 => [180000, 500000],
        20 => [500000, 800000],
        30 => [800000]
    }

    senior_citizen_slabs = reference_slabs.merge({ 0 => [0, 250000], 10 => [250000, 500000] })
    very_senior_citizen_slabs = reference_slabs.merge({ 0 => [0, 500000], 10 => [500000, 500000] })
    {
      :male => {
        :normal => reference_slabs,
        :senior_citizen => senior_citizen_slabs,
        :very_senior_citizen => very_senior_citizen_slabs
      },
      :female => {
        :normal => reference_slabs.merge({ 0 => [0, 190000], 10 => [190000, 500000] }),
        :senior_citizen => senior_citizen_slabs,
        :very_senior_citizen => very_senior_citizen_slabs
      }
    }[sex.downcase.to_sym][senior_citizen]
  end

  def taxable_income
    monthly_deductible = medical_deductible + hra_deductible + conveyence_allowance
    total_deductible = [
        monthly_deductible * 12,
        deductible_under_80cc,
        deductible_under_80ccf,
        interest_on_a_housing_loan_deductible,
        interest_repayment_on_education_loan,
        health_insurance_premiums_deductible
      ].inject(:+)

    ((basic_salary + house_rent_allowance + medical_allowance + conveyence_allowance ) * 12 - total_deductible).round
  end

  def tax_payable
    taxes = slabs(sex, senior_citizen).map { | slab |
      rate = slab[0]
      lower_limit = slab[1][0]
      upper_limit = slab[1][1]

      [( upper_limit ? [taxable_income, upper_limit].min : taxable_income) - lower_limit, 0].max * rate / 100
    }
    tax = taxes.inject(:+)

    tax += tax * 0.03       #education-cess
  end

private
  def hra_deductible
    [
      basic_salary * ( metro ? 0.5 : 0.4 ),
      rent - 0.1 * basic_salary,
      house_rent_allowance
    ].min
  end

  def medical_deductible
    [medical_allowance, 15000].min
  end

  def deductible_under_80cc
    [
      [
        provident_fund,
        unit_linked_insurance_plan,
        national_savings_certificate,
        fixed_deposits_in_scheduled_banks,
        principal_repayment_of_housing_loans,
        stamp_duty_and_registration_charges,
        education_expenses
      ].inject(:+),
      100000
    ].min
  end

  def deductible_under_80ccf
    [infrastructure_bonds, 20000].min
  end

  def interest_on_a_housing_loan_deductible
    [interest_on_a_housing_loan, 150000].min
  end

  def health_insurance_premiums_deductible
    [health_insurance_premium, senior_citizen == :normal ? 15000 : 20000 ].min
  end
end

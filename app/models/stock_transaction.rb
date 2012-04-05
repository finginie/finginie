class StockTransaction < ActiveRecord::Base
  include FungibleTransaction
  attr_accessible :company_code, :company

  belongs_to :portfolio

  validates_presence_of :company_code

  scope :for, lambda { |company| where(:company_code => company.company_code).order(:date, :created_at) } do
    include FungiblePosition

    delegate :company, :to => :first
    delegate :name, :sector, :current_price, :to => :company
  end

  def company
    @company || (company_code && Company.where( company_code: company_code).first)
  end

  def company=(company)
    self.company_code = company.company_code
  end

  alias :security :company
end

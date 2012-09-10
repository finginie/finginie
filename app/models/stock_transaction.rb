class StockTransaction < ActiveRecord::Base
  include FungibleTransaction
  attr_accessible :company_code, :company

  belongs_to :portfolio

  validates_presence_of :company_code

  scope :for, lambda { |company| where(:company_code => company.code).order(:date, :created_at) } do
    include FungiblePosition

    delegate :company, :to => :first
    delegate :name, :sector, :current_price, :to => :company
  end

  after_create :create_event

  def company
    @company ||= (company_code && DataProvider::Company.where( code: company_code).first)
  end

  def company=(company)
    self.company_code = company.code
  end

  alias :security :company

 private

  def create_event
    Event.create do |event|
      event.user = portfolio.user
      event.target = portfolio
      event.action = "stock_#{action}"
      event.data = {'stock' => company_code, 'price' => price}
    end
  end

 end

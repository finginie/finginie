class StockTransaction < ActiveRecord::Base
  include FungibleTransaction

  belongs_to :portfolio
  belongs_to :stock

  validates_presence_of :stock_id

  scope :for, lambda { |stock| where(:stock_id => stock).order(:date, :created_at) } do
    include FungiblePosition

    delegate :stock, :to => :first
    delegate :name, :sector, :current_price, :to => :stock
  end

  alias :security :stock
end

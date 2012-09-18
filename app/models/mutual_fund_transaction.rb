class MutualFundTransaction < ActiveRecord::Base
  include FungibleTransaction
  attr_accessible :scheme

  belongs_to :portfolio
  belongs_to :mutual_fund

  validates_presence_of :mutual_fund_id

  scope :for, lambda { |mutual_fund| where(:mutual_fund_id => mutual_fund.id).order(:date, :created_at) } do
    include FungiblePosition

    delegate :mutual_fund, :to => :first
    delegate :name, :category, :current_price, :to => :mutual_fund
  end

  after_create :create_event

  def scheme
    @scheme ||= mutual_fund && mutual_fund.name
  end

  def scheme=(name)
    self.mutual_fund = MutualFund.find_or_create_by_name(name)
    @scheme = name
  end

  alias :security :mutual_fund


private
  def create_event
    event = Event.create do |event|
      event.user = portfolio.user
      event.target = portfolio
      event.action = "mutual_fund_#{action}"
      event.data = {'scheme' => scheme, 'param' => mutual_fund.scheme_master.slug, 'price' => price}
    end
  end
end

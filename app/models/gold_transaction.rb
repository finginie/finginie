class GoldTransaction < ActiveRecord::Base
  include FungibleTransaction

  belongs_to :portfolio

  scope :for, lambda { |gold| order('date, created_at') } do
    include GoldPosition
  end

  after_create :create_event

  def gold
    DataProvider::Gold
  end
  alias :security :gold

 private

  def create_event
    event = Event.create do |event|
      event.user = portfolio.user
      event.target = portfolio
      event.action = "gold_#{action}"
    end
    # hstore requires object be saved before using hstore
    event.update_attributes :data => { :price => price }
  end
end

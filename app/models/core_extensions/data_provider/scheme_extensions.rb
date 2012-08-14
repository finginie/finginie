require 'kaminari'
require 'kaminari/models/mongoid_extension'

module SchemeExtensions
  extend ActiveSupport::Concern
  module ClassMethods
    def top_gainers(count)
      count ||= 5
      active.equity_funds.order([[ :percentage_change, :desc ]]).limit(count)
    end

    def top_losers(count)
      count ||= 5
      active.equity_funds.where(:percentage_change.lt => 0).order([[ :percentage_change, :asc ]]).limit(count)
    end

    def biggest_funds(count)
      count ||= 5
      active.equity_funds.order([[ :size, :desc ]]).limit(count)
    end
  end
end


DataProvider::Scheme.class_eval do
  include SchemeExtensions
  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document
end

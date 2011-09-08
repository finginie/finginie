class TransactionsController < InheritedResources::Base
  nested_belongs_to :portfolio, :net_position
end

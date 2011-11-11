class RedisRecord < Valuable
  extend ActiveModel::Naming
  include DataTypes
  include Base

  class_attribute :sorted_indices
  self.sorted_indices = []

end

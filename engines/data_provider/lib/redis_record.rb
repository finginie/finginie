class RedisRecord
  include ActiveAttr::Model
  include DataTypes
  include Base

  class_attribute :sorted_indices
  self.sorted_indices = []

end

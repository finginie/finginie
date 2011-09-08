class NetPosition < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :security
end

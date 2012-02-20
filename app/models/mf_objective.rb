class MfObjective
  include Mongoid::Document
  extend MongoidHelpers

  field :securitycode, :type => BigDecimal
  field :objective
  field :modified_date, :type => DateTime
  field :delete_flag

  key :securitycode
end

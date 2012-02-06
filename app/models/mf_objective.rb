class MfObjective
  include Mongoid::Document

  field :securitycode, :type => BigDecimal
  field :objective
  field :modified_date, :type => DateTime
  field :delete_flag

  key :securitycode
end

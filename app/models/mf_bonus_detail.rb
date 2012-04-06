class MfBonusDetail
  include Mongoid::Document
  extend MongoidHelpers

  field :securitycode,   :type => BigDecimal
  field :bonus_date,     :type => Date
  field :ratio_offered,  :type => Float
  field :ratio_existing, :type => Float
  field :remarks
  field :modified_date,  :type => DateTime
  field :delete_flag
  field :row_id,         :type => Integer

  key :securitycode, :bonus_date
end

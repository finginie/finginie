class Split
  include Mongoid::Document

  field :company_code, :type => Float
  field :date_of_announcement, :type => Date
  field :old_face_value, :type => BigDecimal
  field :new_face_value, :type => BigDecimal
  field :record_date, :type => Date
  field :book_closure_start_date, :type => Date
  field :book_closure_end_date, :type => Date
  field :xs_date, :type => Date
  field :modified_date, :type => DateTime
  field :delete_flag

  key :company_code, :date_of_announcement

end

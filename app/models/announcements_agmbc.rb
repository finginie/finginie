class AnnouncementsAgmbc
  include Mongoid::Document
  extend MongoidHelpers

    field :company_code, :type => Float
    field :date_of_announcement, :type => Date
    field :agm_date, :type => Date
    field :year_ending, :type => Date
    field :purpose
    field :record_date, :type => Date
    field :book_closure_start_date, :type => Date
    field :book_closure_end_date, :type => Date
    field :source_code, :type => Integer
    field :source_name
    field :source_date, :type => Date
    field :remarks
    field :modified_date, :type => DateTime
    field :delete_flag

    key :company_code, :date_of_announcement, :agm_date
end

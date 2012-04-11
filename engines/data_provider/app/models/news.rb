class News
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :news_date, :type => Date
  field :headlines
  field :source_name
  field :news_type_description
  field :news_classfication
  field :notes
  field :modify_on, :type => DateTime

  key :company_code, :news_date, :headlines

  scope :for_company, lambda { |company_code| where( company_code: company_code) }
  scope :latest, lambda { |limit| order_by(:modify_on => :desc).limit(limit) }

end

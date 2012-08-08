class CompletedStep < ActiveRecord::Base
  attr_accessible :meta_data, :step, :user_id

  serialize :meta_data, ActiveRecord::Coders::Hstore

end
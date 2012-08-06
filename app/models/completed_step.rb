class CompletedStep < ActiveRecord::Base
  attr_accessible :data, :step_id, :user_id

  serialize :data, ActiveRecord::Coders::Hstore
end

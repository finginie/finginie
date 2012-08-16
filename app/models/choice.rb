class Choice < ActiveRecord::Base
  attr_accessible :text, :score, :ceiling ,:question_id
  belongs_to :question
end

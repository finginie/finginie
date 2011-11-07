class Choice < ActiveRecord::Base
  attr_accessible :text, :score, :ceiling
  belongs_to :question
end

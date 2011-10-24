class Response < ActiveRecord::Base
  belongs_to :risk_profiler
  belongs_to :choice

  attr_writer :question
  def question
    @question ||= choice.try(:question)
  end
end

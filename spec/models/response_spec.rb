require 'spec_helper'

describe Response do
  let (:response) { create :response }
  it "should get the associated question" do
    response.choice = create :choice
    response.question.should eq response.choice.question
  end

  it "should take question assignment" do
    question = create :question
    response.question = question

    response.question.should eq question
  end
end

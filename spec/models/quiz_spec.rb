require 'spec_helper'

describe Quiz do
  let(:quiz) { create :quiz, :name => "Lorem Ipsum" }
  subject { quiz }

  its(:slug) { should eq 'lorem-ipsum' }
end

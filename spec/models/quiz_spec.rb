require 'spec_helper'

describe Quiz do
  let(:quiz) { create :quiz, :name => "Lorem Ipsum" }
  subject { quiz }

  its(:slug) { should eq 'lorem-ipsum' }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :slug }
  it { should validate_numericality_of :weight }
  its(:weight) { should eq 1 }
  it { should validate_presence_of :result_type }
  it { should_not allow_value("blah").for(:result_type) }
  it { should allow_value("mean").for(:result_type) }
  it { should allow_value("mode").for(:result_type) }
end

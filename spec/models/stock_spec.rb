require 'spec_helper'

describe Stock do
  before { create :stock }
  it { should validate_uniqueness_of :name }
end

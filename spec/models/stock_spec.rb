require 'spec_helper'

describe Stock do
  let (:stock) { create :stock }
  subject { stock }

  it { should validate_uniqueness_of :name }

end

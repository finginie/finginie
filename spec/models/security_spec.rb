require 'spec_helper'

describe Security do
  it { should validate_presence_of :name }
end

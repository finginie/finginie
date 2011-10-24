require 'spec_helper'

describe Question do
  it { should validate_presence_of :text }
end

require 'spec_helper'

describe StockTransaction do
  it { should validate_presence_of :price }
  it { should validate_presence_of :quantity }
  it { should belong_to :portfolio }
  it { should belong_to :stock }
end

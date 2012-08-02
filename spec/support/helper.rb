def tableish(element)
  rows = page.find(element).all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip.gsub(/\s+/, ' ') } }
end

def span_data_role(attr)
  content_selector("span[data-role='#{attr}']")
end

def content_selector(element)
  page.find(element).text.strip.gsub(/\s+/, ' ')
end

#named scope tests
def test_named_scope(all_objects, subset, condition)
  scoped_objects, other_objects = all_objects.partition(&condition)
  scoped_objects.should_not be_empty
  other_objects.should_not be_empty
  scoped_objects.should == subset
  other_objects.should == all_objects - subset
end

def table_rows(sub, element)
  sub.find(element).all('tr').map { |r| r.all('th,td').map { |c| c.text.strip.gsub(/\s+/, ' ') } }
end

RSpec::Matchers.define :be_a_indian_currency_of do |expected|
  match do |actual|
    actual.should eq IndianCurrency.new(expected)
  end
end

RSpec::Matchers.define :have_span_data_role do |expected|
  match do |actual|
    should have_selector("span[data-role='#{expected}']")
  end
end

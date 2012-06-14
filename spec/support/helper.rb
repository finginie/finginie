def tableish(element)
  rows = page.find(element).all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip.gsub(/\s+/, ' ') } }
end

def selector(element, tag)
  elements = page.find(element).all(tag)
  content = elements.map { |element| element.text.strip.gsub(/\s+/, ' ') }
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

def tableish(element)
  rows = page.find(element).all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip.gsub(/\s+/, ' ') } }
end

def selector(element, tag)
  elements = page.find(element).all(tag)
  content = elements.map { |element| element.text.strip.gsub(/\s+/, ' ') }
end

def tableish(element)
  rows = page.find(element).all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip.gsub(/\s+/, ' ') } }
end


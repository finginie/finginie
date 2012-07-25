def should_have_data_role(tag, content)
  page.should have_xpath(".//#{tag}[@data-role='#{content}']")
end

def find_data_role(tag, content)
  find(:xpath, ".//#{tag}[@data-role='#{content}']")
end

def have_error_message(name)
  have_selector("input[name='#{name}']+span.help-inline")
end

Capybara.add_selector(:link) do
  xpath { |content| ".//a[@href='#{content}']" }
end

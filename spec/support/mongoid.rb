RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.after(:each, :mongoid) do
    puts "cleaning mongodb...."
    Mongoid.purge!
    puts "finished cleaning mongodb."
  end
end

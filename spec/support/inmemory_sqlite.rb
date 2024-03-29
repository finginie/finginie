def in_memory_database?
  ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLiteAdapter ||
    ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter and
  Rails.configuration.database_configuration['test']['database'] == ':memory:'
end

if in_memory_database?
  puts "creating sqlite in memory database"
  silence_stream(STDOUT) do
    load "#{Rails.root}/db/schema.rb"
  end
end

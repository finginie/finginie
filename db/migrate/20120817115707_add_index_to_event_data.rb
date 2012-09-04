class AddIndexToEventData < ActiveRecord::Migration
  def up
    execute "CREATE INDEX events_data ON events USING GIN(data)"
  end

  def down
    execute "DROP INDEX events_data"
  end
end

class CreateEventUpdates < ActiveRecord::Migration
  def change
    create_table :event_updates do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :event_updates, :user_id
    add_index :event_updates, :event_id
  end
end

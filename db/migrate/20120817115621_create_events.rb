class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.references :target, :polymorphic => true
      t.string :action
      t.hstore :data

      t.timestamps
    end
    add_index :events, :user_id
    add_index :events, :target_id
    add_index :events, :target_type
    add_index :events, :action
  end
end

class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :subscribable, :polymorphic => true

      t.timestamps
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :subscribable_id
  end
end

class RemoveAuthentication < ActiveRecord::Migration
  def up
    drop_table :authentications
  end

  def down
    create_table :authentications do |t|
      t.references :user
      t.string :provider
      t.string :uid

      t.timestamps
    end
    add_index :authentications, :user_id
  end
end

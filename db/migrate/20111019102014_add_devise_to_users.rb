class AddDeviseToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      # t.database_authenticatable :null => false # Clearance Already took care of this for us
      # t.recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      # t.rememberable
      t.datetime :remember_created_at
      # t.trackable
      t.integer :sign_in_count
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    # add_index :users, :email,                :unique => true # Clearance Already took care of this for us
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end
end

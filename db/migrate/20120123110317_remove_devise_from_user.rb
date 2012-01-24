class RemoveDeviseFromUser < ActiveRecord::Migration
  def change
    change_table 'users' do |t|
      t.remove_index :name => "index_users_on_remember_token"
      t.remove_index :name => "index_users_on_reset_password_token"

      t.remove  :encrypted_password, :salt, :confirmation_token, :remember_token,
                :reset_password_token, :reset_password_sent_at, :remember_created_at,
                :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
                :last_sign_in_ip
    end
  end
end

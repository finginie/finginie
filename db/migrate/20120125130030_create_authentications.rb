class CreateAuthentications < ActiveRecord::Migration
  def change
    rename_table :clearance_omniauth_authentications, :authentications
  end
end

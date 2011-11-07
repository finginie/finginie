class CreateRiskProfilers < ActiveRecord::Migration
  def change
    create_table :risk_profilers do |t|
      t.references :quiz
      t.references :user
      t.decimal :score

      t.timestamps
    end
    add_index :risk_profilers, :quiz_id
    add_index :risk_profilers, :user_id
  end
end

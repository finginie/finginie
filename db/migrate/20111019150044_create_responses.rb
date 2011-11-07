class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :risk_profiler
      t.references :choice

      t.timestamps
    end
    add_index :responses, :risk_profiler_id
    add_index :responses, :choice_id
  end
end

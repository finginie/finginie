class CreateCompletedSteps < ActiveRecord::Migration
  def change
    create_table :completed_steps do |t|
      t.integer :user_id
      t.integer :step_id
      t.hstore :data
    end
  end
end

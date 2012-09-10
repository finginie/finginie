class AddTimestampsToCompletedSteps < ActiveRecord::Migration
  def up
    add_column(:completed_steps, :created_at, :datetime)
    add_column(:completed_steps, :updated_at, :datetime)
  end

  def down
    remove_column :completed_steps, :created_at
    remove_column :completed_steps, :updated_at
  end
end
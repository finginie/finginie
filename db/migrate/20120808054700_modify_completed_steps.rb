class ModifyCompletedSteps < ActiveRecord::Migration
  def up
    remove_column :completed_steps, :step_id
    add_column :completed_steps, :step, :string
    rename_column :completed_steps, :data, :meta_data
  end

  def down
    remove_column :completed_steps, :step
    add_column :completed_steps, :step_id, :integer
    rename_column :completed_steps, :meta_data, :data
  end
end

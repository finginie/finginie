class RemoveStepsTable < ActiveRecord::Migration
  def up
    drop_table :steps
  end

  def down
    create_table :steps do |t|
      t.string :name
      t.string :description
      t.string :action_link
      t.points :integer
    end
  end
end
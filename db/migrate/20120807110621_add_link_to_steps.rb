class AddLinkToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :completion_link, :string
  end
end

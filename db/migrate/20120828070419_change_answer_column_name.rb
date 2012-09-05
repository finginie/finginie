class ChangeAnswerColumnName < ActiveRecord::Migration
  def change
    rename_column :questions, :answer, :correct_choice_id
  end

end

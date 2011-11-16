class ModifyColumnsFromQuiz < ActiveRecord::Migration
  def change
    change_table :quizzes do |t|
      t.rename :type, :result_type
      t.string :buckets
    end
  end
end

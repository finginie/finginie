class ModifyColumnsFromQuiz < ActiveRecord::Migration
  change_table :quizzes do |t|
     t.rename :type, :result_type
     t.string :buckets
  end
end

class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :type
      t.string :name
      t.decimal :weight

      t.timestamps
    end
  end
end

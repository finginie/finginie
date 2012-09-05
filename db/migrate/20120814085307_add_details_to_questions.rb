class AddDetailsToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :news, :text
    add_column :questions, :reason, :text
    add_column :questions,:answer, :integer
  end

  def down
    remove_column :questions, :news
    remove_column :questions, :reason
    remove_column :questions, :answer
  end

end

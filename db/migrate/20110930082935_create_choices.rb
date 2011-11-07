class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.decimal :score
      t.text :text
      t.decimal :ceiling
      t.references :question

      t.timestamps
    end
    add_index :choices, :question_id
  end
end

class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :question
      t.string :answer
      t.string :question_de
      t.string :answer_de

      t.timestamps
    end
  end
end

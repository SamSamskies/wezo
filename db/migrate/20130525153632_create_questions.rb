class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user
      t.string :question
      t.string :status
      t.timestamps
    end
  end
end

class AddAutorToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :autor, :string
  end
end

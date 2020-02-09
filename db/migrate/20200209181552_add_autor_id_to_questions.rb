class AddAutorIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :autor_id, :string
  end
end

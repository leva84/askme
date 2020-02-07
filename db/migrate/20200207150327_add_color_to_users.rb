class AddColorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favorite_color, :string
  end
end

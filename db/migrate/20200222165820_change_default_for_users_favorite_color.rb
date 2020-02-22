class ChangeDefaultForUsersFavoriteColor < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :favorite_color, :string, :default => '#005a55'
  end
end

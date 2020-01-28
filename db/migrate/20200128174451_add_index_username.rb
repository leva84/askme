class AddIndexUsername < ActiveRecord::Migration[5.2]
  def change
    create_table :usernames do |t|
      t.index :username
    end
  end
end

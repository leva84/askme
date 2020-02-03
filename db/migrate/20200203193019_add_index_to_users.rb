class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end
end

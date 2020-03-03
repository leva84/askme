class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name, default: ""

      t.timestamps
    end
  end
end

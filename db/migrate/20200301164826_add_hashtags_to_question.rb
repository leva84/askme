class AddHashtagsToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :hashtags, :text, default: ""
  end
end

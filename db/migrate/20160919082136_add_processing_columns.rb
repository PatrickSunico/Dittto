class AddProcessingColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_processing, :boolean, null: false, default: false
    add_column :posts, :thumbnail_processing, :boolean, null: false, default: false
    add_column :attachments, :thumbnail_processing, :boolean, null: false, default: false
  end
end

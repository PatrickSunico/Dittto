class RemoveProcessingColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :avatar_processing, :boolean, null: false, default: false
    remove_column :posts, :thumbnail_processing, :boolean, null: false, default: false
    remove_column :attachments, :thumbnail_processing, :boolean, null: false, default: false
  end
end

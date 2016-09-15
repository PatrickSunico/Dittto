class AddThumbnailProcessingColumnToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :thumbnail_processing, :boolean, null: false, default: false
  end
end

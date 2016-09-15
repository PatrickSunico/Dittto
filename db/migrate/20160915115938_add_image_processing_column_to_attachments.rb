class AddImageProcessingColumnToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :thumbnail_processing, :boolean, null: false, default: false
  end
end

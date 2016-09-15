class AddAvatarProcessingColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_processing, :boolean, null: false, default: false
  end
end

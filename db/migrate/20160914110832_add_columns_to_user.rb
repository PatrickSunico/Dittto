class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :location, :string
    add_column :users, :occupation, :string
    add_column :users, :company, :string
    add_column :users, :website, :string
  end
end

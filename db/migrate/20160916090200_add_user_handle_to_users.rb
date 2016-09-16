class AddUserHandleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :userhandle, :string
  end
end

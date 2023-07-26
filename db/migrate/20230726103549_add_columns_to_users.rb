class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :string
    add_column :users, :address, :string
    add_column :users, :post_code, :string
  end
end

class AddCategoryAndUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :category, :string, default: "owner"
    add_column :users, :username, :string
  end
end

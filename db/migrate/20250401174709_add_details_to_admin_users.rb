class AddDetailsToAdminUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :last_name, :string
    add_column :admin_users, :first_name, :string
    add_column :admin_users, :middle_name, :string
    add_column :admin_users, :position, :string
  end
end

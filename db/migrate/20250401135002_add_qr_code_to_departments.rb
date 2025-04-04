class AddQrCodeToDepartments < ActiveRecord::Migration[8.0]
  def change
    add_column :departments, :qr_code, :string
  end
end

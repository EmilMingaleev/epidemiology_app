ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :admin, :last_name, :first_name, :middle_name, :position

  index do
    selectable_column
    id_column
    column :email
    column :admin
    column :last_name
    column :first_name
    column :middle_name
    column :position
    actions
  end

  filter :email
  filter :last_name
  filter :first_name
  filter :middle_name
  filter :position
  filter :admin

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin
      f.input :last_name
      f.input :first_name
      f.input :middle_name
      f.input :position
    end
    f.actions
  end
end

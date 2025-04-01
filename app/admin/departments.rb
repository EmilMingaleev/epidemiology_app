ActiveAdmin.register Department do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    actions
  end

  filter :name
  filter :description
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end
end

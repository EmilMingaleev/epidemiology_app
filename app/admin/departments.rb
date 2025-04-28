ActiveAdmin.register Department do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    column "QR Code" do |department|
      if department.qr_code.attached?
        image_tag url_for(department.qr_code), size: "50x50"
      else
        "No QR Code"
      end
    end
    actions
  end

  filter :name
  filter :description
  filter :created_at

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row "QR Code" do |department|
        if department.qr_code.attached?
          image_tag url_for(department.qr_code), size: "200x200"
        else
          "No QR Code"
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end
end

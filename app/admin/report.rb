ActiveAdmin.register Report do
  permit_params :department_id, :user_id, :pdf

  filter :pdf_filename_cont, as: :string, label: 'Название PDF'

  index do
    selectable_column
    id_column
    column :department
    column :user
    column "PDF File" do |report|
      if report.pdf.attached?
        link_to "Download PDF", rails_blob_path(report.pdf, disposition: "attachment"), target: "_blank"
      else
        "No PDF"
      end
    end
    column :created_at
    actions
  end
end

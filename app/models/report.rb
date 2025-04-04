class Report < ApplicationRecord
  belongs_to :department
  belongs_to :user

  has_one_attached :pdf

  validates :pdf, presence: true
  validate :pdf_is_pdf

  def self.ransackable_associations(_auth_object = nil)
    %w[department user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id department_id user_id created_at updated_at pdf_filename]
  end

  def pdf_filename
    pdf.attached? ? pdf.filename.to_s : nil
  end

  private

  def pdf_is_pdf
    return unless pdf.attached? && pdf.content_type != 'application/pdf'

    errors.add(:pdf, 'must be a PDF file')
  end
end

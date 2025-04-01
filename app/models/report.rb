class Report < ApplicationRecord
  belongs_to :department
  belongs_to :user

  has_one_attached :pdf

  validates :pdf, presence: true
  validate :pdf_is_pdf

  private

  def pdf_is_pdf
    return unless pdf.attached? && pdf.content_type != 'application/pdf'

    errors.add(:pdf, 'must be a PDF file')
  end
end

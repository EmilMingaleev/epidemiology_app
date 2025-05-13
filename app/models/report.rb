class Report < ApplicationRecord
  belongs_to :department
  belongs_to :user

  has_one_attached :pdf

  validates :pdf, presence: true
  validate :pdf_is_pdf

  after_create :notify_telegram

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

  def notify_telegram
    message = <<~MSG
      📝 *Создан новый отчёт* (ID: #{id})

      *Пользователь:* #{begin
        user.full_name
      rescue StandardError
        user.email
      end}
      *Отдел:* #{department.name}
      *Комментарий:* #{comments.presence || '—'}
      *Файл:* #{pdf_filename}

      📅 Создан: #{created_at.strftime('%d.%m.%Y %H:%M')}
    MSG

    TelegramNotifier.send_message(message, parse_mode: 'Markdown')
  end
end

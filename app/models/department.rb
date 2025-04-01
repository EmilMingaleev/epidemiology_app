class Department < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_one_attached :qr_code

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description created_at updated_at]
  end

  after_create :generate_qr_code

  private

  def generate_qr_code
    qr = RQRCode::QRCode.new(Rails.application.routes.url_helpers.department_url(self, host: "localhost:3000"))

    png = qr.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      size: 300
    )

    qr_code.attach(
      io: StringIO.new(png.to_s),
      filename: "department_#{id}_qr.png",
      content_type: "image/png"
    )
  end
end

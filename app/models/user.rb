class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def full_name
    "#{last_name} #{first_name} #{middle_name}".strip
  end

  def admin?
    admin
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[admin created_at email encrypted_password id remember_created_at reset_password_sent_at
       reset_password_token updated_at last_name first_name middle_name position]
  end
end

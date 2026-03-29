class User < ApplicationRecord
  belongs_to :shop
  has_secure_password

  validates :name, presence: true
  validates :email,
            uniqueness: { case_sensitive: false, allow_blank: true },
            format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
  validates :cellphone, uniqueness: { allow_blank: true }
  validate :email_or_cellphone_present

  before_save :normalize_email

  private

  def email_or_cellphone_present
    errors.add(:base, "Email or cellphone must be present") if email.blank? && cellphone.blank?
  end

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end

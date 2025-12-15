class UserAccount < ActiveRecord::Base
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: { message: "email already exists" }
  validate :is_columbia_email
  validate :strong_password


  def is_columbia_email
    return if email.blank?
    unless self.email.match?(/^[A-Za-z]{2,3}\d{4}@(columbia|barnard)\.edu$/)
      errors.add(:email, "must be a valid Columbia or Barnard email address")
    end
  end
  
  def strong_password
    if password.blank?
      return
    end
    unless self.password.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}\z/)
      errors.add(:password, "must be a strong password that is at least 8 characters and includes a lowercase letter, an uppercase letter, a number, and a special character")
    end
  end
end


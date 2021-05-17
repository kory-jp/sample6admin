class Customer < ApplicationRecord
  include StringNormalizer

  has_many :events, class_name: "CustomerEvent", dependent: :destroy

  before_validation do
    self.email = normalize_as_email(email)
    self.name = normalize_as_name(name)
    self.nickname = normalize_as_nickname(nickname)
  end

  HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}A-Za-z]+\z/

  validates :email, presence: true, "valid_email_2/email": true, uniqueness: {case_sensitive: false}
  validates :name, presence: true, format: {with: HUMAN_NAME_REGEXP, allow_blank: true}

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil 
    end
  end

  def active?
    !suspended?
  end
end

class Customer < ApplicationRecord
  include StringNormalizer
  include EmailHolder
  include PasswordHolder

  has_many :events, class_name: "CustomerEvent", dependent: :destroy
  has_many :posts, dependent: :destroy

  before_validation do
    self.name = normalize_as_name(name)
    self.nickname = normalize_as_nickname(nickname)
  end

  # 空白可能
  # HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}A-Za-z]+\z+\s|/
  # 空白不可
  HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}A-Za-z]+\z/

  validates :name, presence: true, format: {with: HUMAN_NAME_REGEXP, allow_blank: true}

  def active?
    !suspended?
  end
end

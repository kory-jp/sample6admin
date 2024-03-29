class Post < ApplicationRecord
  belongs_to :customer

  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 1000}
end

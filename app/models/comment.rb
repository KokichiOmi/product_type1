class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, length: { in: 1..140 }
end

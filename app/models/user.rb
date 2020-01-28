class User < ApplicationRecord
  has_many :posts,
           dependent: :destroy,
           foreign_key: :author_id
  has_many :comments,
           dependent: :destroy,
           foreign_key: :author_id

  has_many :income_comments, through: :posts
end

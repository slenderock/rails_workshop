class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_one :image, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy
end

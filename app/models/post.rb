class Post < ApplicationRecord
  has_many :replies, class_name: 'Post', foreign_key: 'post_id'
  belongs_to :topic
  belongs_to :original_post, class_name: 'Post', foreign_key: 'post_id', optional: true
  validates :name, presence: true
  validates :body, presence: true
end

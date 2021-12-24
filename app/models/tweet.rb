class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :tweet, presence: true,length: { in: 5..100}
end

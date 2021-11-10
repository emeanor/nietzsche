class User < ApplicationRecord

  has_many :editions

  validates :username, length: { maximum: 255 }, presence: true, uniqueness: true

end
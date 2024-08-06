class User < ApplicationRecord
  has_secure_password
  before_create :get_random_api_key

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 7 }, on: :create

  private 

  def get_random_api_key
    self.api_key = SecureRandom.hex(16)
  end
end

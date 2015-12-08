class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name, :location, presence: true
  validates :email, :username, { presence: true, uniqueness: true }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
end

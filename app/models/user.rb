class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :username, :last_name, presence: true
  validates :email, { presence: true, uniqueness: true }
end

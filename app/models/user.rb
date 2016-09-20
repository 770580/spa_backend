class User < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
 
  validates :password, length: { minimum: 3 }
 
  has_secure_password
end

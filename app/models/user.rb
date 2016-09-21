class User < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
 
  validates :password, length: { minimum: 3 }
 
  has_secure_password

  def self.from_token_request request
    name = request.params["auth"] && request.params["auth"]["name"]
    find_by name: name
  end
end

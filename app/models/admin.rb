class Admin < ApplicationRecord
  has_secure_password
  validates :name, :email, :password, :phonenumber, presence: true
  belongs_to :user
end

class LeasingAgent < ApplicationRecord
  has_secure_password
  validates :name, :email, :password, :phone_number, presence: true
  has_many :applications
  belongs_to :user
end

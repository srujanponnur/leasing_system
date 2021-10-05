class Applicant < ApplicationRecord
  has_secure_password
  validates :name, :email, :password, :phone_number, presence: true
  has_many :applications, dependent: :destroy
  belongs_to :user
  has_one :property
  has_many :occupants, dependent: :destroy
end

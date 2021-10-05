class Property < ApplicationRecord
  validates :name, :address, :size, :terms_available, :earliest_start_date, :application_fee, :monthly_rent, :units, presence: true
  validates :size, :terms_available, :monthly_rent, :units, numericality: { greater_than: -1 }
  has_many :applications, dependent: :destroy
  belongs_to :applicant, optional: true
  belongs_to :property_feature, optional: true
  has_many :occupants, dependent: :destroy
end

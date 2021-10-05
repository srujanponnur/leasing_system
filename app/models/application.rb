class Application < ApplicationRecord
  belongs_to :property
  belongs_to :applicant
  belongs_to :leasing_agent, optional: true
  validates :property_id, uniqueness: { scope: [:property_id, :applicant_id]}
end

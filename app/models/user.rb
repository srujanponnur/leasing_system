class User < ApplicationRecord
  has_one :applicant
  has_one :leasing_agent
  has_one :admin
end

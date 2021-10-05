json.extract! applicant, :id, :name, :password, :email, :phone_number, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)

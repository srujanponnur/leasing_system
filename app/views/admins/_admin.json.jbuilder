json.extract! admin, :id, :email, :password, :name, :phonenumber, :created_at, :updated_at
json.url admin_url(admin, format: :json)

json.extract! user, :id, :username, :user_type, :created_at, :updated_at
json.url user_url(user, format: :json)

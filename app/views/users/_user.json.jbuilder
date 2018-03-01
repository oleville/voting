json.extract! user, :id, :name, :username, :email, :auth_token, :auth_token_expiration, :created_at, :updated_at
json.url user_url(user, format: :json)

json.extract! election, :id, :name, :description, :start_time, :end_time, :created_at, :updated_at
json.url election_url(election, format: :json)

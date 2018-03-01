json.extract! ballot, :id, :user_id, :election_id, :created_at, :updated_at
json.url ballot_url(ballot, format: :json)

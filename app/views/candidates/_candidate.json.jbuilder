json.extract! candidate, :id, :name, :picture_url, :description, :election_id, :position_id, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)

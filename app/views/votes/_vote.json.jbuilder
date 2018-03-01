json.extract! vote, :id, :rank, :candidate_id, :user_id, :election_id, :position_id, :created_at, :updated_at
json.url vote_url(vote, format: :json)

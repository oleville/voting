require 'date'

class Election < ApplicationRecord
	has_many :positions, dependent: :destroy
	has_many :ballots, dependent: :destroy

	def self.currently_open
		self.select do |election|
			election.is_open?
		end
	end

	def self.currently_open_to(user)
		return self.all if user && user.is_admin?

		# TODO use AR
		self.select do |election|
			election.is_open?
		end
	end

	def positions_for(user)
		Position.where(group_id: nil, election_id: id) +
			user.positions.where(election_id: id)
	end

	def results
		simple_results = positions.map do |position|
			remaining_candidates = position.candidates

			position_ballots = position.ballots.uniq
			ballots = position_ballots.map do |ballot|
				hash = { ballot: ballot, id: id, user_id: ballot.user_id, current_rank: ballot.votes.sort do |vote_a, vote_b|
						vote_a.rank <=> vote_b.rank
					end.first.rank }
				hash[:votes] = ballot.votes.select do |vote|
					vote && vote.rank && vote.rank >= hash[:current_rank]
				end
				hash[:current_vote] = hash[:votes].select do |vote|
					vote.position_id == position.id
					vote.rank == hash[:current_rank]
				end.first

				hash
			end

			until remaining_candidates.count <= 1
				candidate_to_nix = remaining_candidates.sort do |candidate_a, candidate_b|
					candidate_a_count = ballots.select do |ballot|
						ballot[:current_vote].candidate == candidate_a
					end.count

					candidate_b_count = ballots.select do |ballot|
						ballot[:current_vote].candidate == candidate_b
					end.count

					candidate_b_count <=> candidate_a_count
				end.last

				ballots.each do |ballot|
					ballot[:current_rank] += 1
					ballot[:current_vote] = ballot[:votes].select do |vote|
						vote.position_id == position.id
						vote.rank == ballot[:current_rank]
					end.first
				end

				remaining_candidates = remaining_candidates.select do |candidate|
					candidate != candidate_to_nix
				end
			end

			[position, remaining_candidates[0]]
		end.to_h

		simple_results.map do |position, candidate|
			simple_results[position] = { candidate: candidate, write_ins: WriteIn.where(position_id: position.id, rank: 1..Float::INFINITY) }
		end

		simple_results
	end

	def has_public_results?
		!is_open? && validated && results_public
	end

	def to_s
		name
	end

	def is_open?
		now = DateTime.now
		(start_time <= now) && (now < end_time)
	end
end

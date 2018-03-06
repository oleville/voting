class BallotsController < ApplicationController
	before_action :set_ballot, only: [:destroy]
	before_action :set_election, only: [:new, :create]

	# GET /ballots
	# GET /ballots.json
	def index
		require_admin!

		@ballots = Ballot.all
	end

	# GET /ballots/new
	def new
		require_login!

		if !@election
			if (@currently_open_elections = Election.currently_open).count > 0
				redirect_to new_ballot_path(params: { election_id: @currently_open_elections.first.id }) and return
			else
				redirect_to root_path, notice: "No currently open elections."
			end
		end

		ensure_not_voted_yet!

		if !@election.is_open?
			redirect_to root_path, notice: 'This election is not currently open.'
		end

		@ballot = Ballot.new
	end

	# POST /ballots
	# POST /ballots.json
	def create
		require_login!

		ensure_not_voted_yet!

		@ballot = Ballot.new(ballot_params)

		respond_to do |format|
			if @ballot.save
				format.html { redirect_to root_path, notice: 'You have successfully voted.' }
				format.json { render :show, status: :created, location: @ballot }
			else
				format.html { redirect_to new_ballot_path(params: { election_id: @election.id }) }
				format.json { render json: @ballot.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /ballots/1
	# DELETE /ballots/1.json
	def destroy
		require_admin!

		@ballot.destroy

		respond_to do |format|
			format.html { redirect_to ballots_url, notice: 'Ballot was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def ensure_not_voted_yet!
		if @election && @current_user.ballots.where(election_id: @election.id).count > 0
			redirect_to root_path, notice: 'You have already voted.'
		end
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_ballot
		@ballot = Ballot.find(params[:id])
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_election
		begin
			@election = Election.find(params[:election_id])
		rescue
			return nil
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def ballot_params
		params.require(:ballot).permit(:user_id, :election_id, :votes_attributes => [:rank, :user_id, :ballot_id, :candidate_id, :position_id])
	end
end

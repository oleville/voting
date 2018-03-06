class ElectionsController < ApplicationController
	before_action :set_election, only: [:show, :edit, :live, :results, :update, :destroy]

	# GET /elections
	# GET /elections.json
	def index
		require_admin!
		@elections = Election.all
	end

	# GET /elections/1
	# GET /elections/1.json
	def show
		require_admin!
	end

	# GET /elections/new
	def new
		require_admin!
		@election = Election.new
	end

	# GET /elections/1/edit
	def edit
		require_admin!
	end

	# GET /elections/1/live
	def live
		require_login!

		@voted_so_far = @election.ballots.count || 0
		@total_users = User.count || 1

		@percentage = @voted_so_far.to_f / @total_users.to_f
	end

	# GET /elections/1/results
	def results
		require_admin! unless @election.has_public_results?

		@results = @election.results
	end

	# POST /elections
	# POST /elections.json
	def create
		require_admin!
		@election = Election.new(election_params)

		respond_to do |format|
			if @election.save
				format.html { redirect_to @election, notice: 'Election was successfully created.' }
				format.json { render :show, status: :created, location: @election }
			else
				format.html { render :new }
				format.json { render json: @election.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /elections/1
	# PATCH/PUT /elections/1.json
	def update
		require_admin!
		respond_to do |format|
			if @election.update(election_params)
				format.html { redirect_to @election, notice: 'Election was successfully updated.' }
				format.json { render :show, status: :ok, location: @election }
			else
				format.html { render :edit }
				format.json { render json: @election.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /elections/1
	# DELETE /elections/1.json
	def destroy
		require_admin!
		@election.destroy
		respond_to do |format|
			format.html { redirect_to elections_url, notice: 'Election was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_election
		@election = Election.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def election_params
		params.require(:election).permit(:name, :description, :validated, :results_public, :start_time, :end_time)
	end
end

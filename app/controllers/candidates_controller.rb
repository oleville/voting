class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  # GET /candidates
  # GET /candidates.json
	def index
		require_login!
		@candidates = Candidate.all
  end

  # GET /candidates/1
  # GET /candidates/1.json
	def show
		require_login!
  end

  # GET /candidates/new
	def new
		require_admin!
    @candidate = Candidate.new
  end

  # GET /candidates/1/edit
	def edit
		require_admin!
  end

  # POST /candidates
  # POST /candidates.json
	def create
		require_admin!

    @candidate = Candidate.new(candidate_params)

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
	def update
		require_admin!

    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
	  require_admin!

	  @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url, notice: 'Candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_candidate
	  @candidate = Candidate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidate_params
	  params.require(:candidate).permit(:name, :picture_url, :description, :violations, :election_id, :position_id)
  end
end

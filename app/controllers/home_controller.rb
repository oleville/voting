class HomeController < ApplicationController
	def show
		@votable_elections = Election.currently_open_to(@current_user)

		if @votable_elections.count == 1 && current_user && !current_user.is_admin?
			redirect_to new_ballot_url(params: {election_id: @votable_elections.first.id})
		end
  end
end

class HomeController < ApplicationController
	def show
		@votable_elections = Election.currently_open_to(@current_user)
  end
end

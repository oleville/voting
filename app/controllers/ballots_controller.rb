class BallotsController < ApplicationController
	def create
		@elections = Election.currently_open_to(current_user)
		@positions = @elections.map do |election|
			election.positions
		end.flatten
  end
end

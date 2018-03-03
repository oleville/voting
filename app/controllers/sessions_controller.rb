class SessionsController < ApplicationController
	def create
		user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

	def destroy
		if user = current_user
			begin
				puts "Revoking token for user #{user.id}"

				uri = URI('https://accounts.google.com/o/oauth2/revoke')
				params = { :token => current_user.auth_token }
				uri.query = URI.encode_www_form(params)
				response = Net::HTTP.get(uri)
			rescue RuntimeError => e
				puts e
			end
		end

		session[:user_id] = nil
		redirect_to root_path
  end
end

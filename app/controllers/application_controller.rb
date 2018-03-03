class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

	private

	def current_user
		begin
			@current_user ||= User.find(session[:user_id]) if session[:user_id]

			if Time.at(@current_user.auth_token_expiration) <= Time.now
				@current_user = nil
			end

			return @current_user
		rescue
			@current_user = nil
		end
	end

	def require_login!
		redirect_to :root if current_user.nil?
	end

	def require_admin!
		if !current_user || !current_user.admin?
			redirect_to :root, notice: "Not allowed to access this resource."
		end
	end
end

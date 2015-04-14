module SessionsHelper

	# Log in given user. Places temorary cookie on user's browser containining encrypted version of user's id. 
	def log_in(user)
		session[:user_id] = user.id
	end

	# Returns the current logged-in user if there is one. 
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# Returns true if user is logged-in, i.e. if current_user is not nil. 
	def logged_in?
		!current_user.nil?
	end
end

class SessionsController < ApplicationController
  def new
  end

  def create
  	# Pulls the user from database.
  	user = User.find_by(email: params[:session][:email].downcase)
  	# Determine if user is valid. 
  	if user && user.authenticate(params[:session][:password])
  		# Log in the user and redirect to user's show page.
  		log_in user
  		redirect_to user
  	else
  		# Create error message. .now makes sure message disappear as soon as there is an additional request.
  		flash.now[:danger] = "Fel kombination av e-post och lösenord."
  		# And then renders the new view.
  		render 'new'
  	end
  end

  def destroy

  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# Log in the user and redirect to user's show page.
  	else
  		# Create error message. .now makes sure message disappear as soon as there is an additional request.
  		flash.now[:danger] = "Fel kombination av e-post och lösenord."
  		render 'new'
  	end
  end

  def destroy

  end
end

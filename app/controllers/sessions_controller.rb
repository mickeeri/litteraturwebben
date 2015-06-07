class SessionsController < ApplicationController
  def new
    # Store session to redirect user to same page after login.
    # http://stackoverflow.com/questions/2139996/ruby-on-rails-redirect-toback
    session[:return_to] ||= request.referer
  end

  def create
    # Pulls the user from database.
    user = User.find_by(email: params[:session][:email].downcase)
    # Verifies that user is valid.
    if user && user.authenticate(params[:session][:password])
      # Log in the user and redirect to user's show page.
      log_in user
      # If user has checked remember_me checkbox (value = 1), then remember user, else forget user.
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # Redirects to requested url or default. See sessions_helper.
      redirect_to session.delete(:return_to) || root_url
    else
      # Create error message. .now makes sure message disappear as soon as there is an additional request.
      flash.now[:danger] = "Fel kombination av e-post och lösenord."
      # And then renders the new view.
      render 'new'
    end
  end

  def destroy
    # Call session helper method log_out
    log_out if logged_in?
    redirect_to root_url
  end
end

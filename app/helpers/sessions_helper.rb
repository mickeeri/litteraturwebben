module SessionsHelper

    # Log in given user. Places temorary cookie on user's browser containining encrypted version of user's id.
    def log_in(user)
        session[:user_id] = user.id
    end

    # Calls user.remember, generating remember token and saving its digest to database.
    def remember(user)
        user.remember
        # Uses cookies create permanent cookies for user id.
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def current_user?(user)
        user == current_user
    end

    # Returns the current logged-in user. Retrieve user from temprary session if session[:user_id] exists, otherwise look for it in
    # cookies[:user_id] to retrieve user from persistent session.
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    # Returns true if user is logged-in, i.e. if current_user is not nil.
    def logged_in?
        !current_user.nil?
    end

    # Deletes user_id and remeber_token cookies.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # Logs out current user.
    def log_out
        # Removes user from persistent session.
        forget(current_user)
        # Deleting current user id from session.
        session.delete(:user_id)
        # Sets current user to nil.
        @current_user = nil
    end

    # Redirects to stored requested url if it exists, otherwise to default url in Sessions controller create method.
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    # Stores the URL trying to be acessed.
    def store_location
        # request.url = get url of requested page. Puts requested url in session variable under key :forwarding_url, but only if request is GET.
        session[:forwarding_url] = request.url if request.get?
    end
end

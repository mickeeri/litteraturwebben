class PasswordResetsController < ApplicationController
	before_action :get_user, only: [:edit, :update]
	before_action :valid_user, only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]

	def new
	end

	def create
		@user = User.find_by(email: params[:password_reset][:email].downcase)
		if @user
			@user.create_reset_digest
			@user.send_password_reset_email
			flash[:info] = "Ett mail med instruktioner för återställning av lösenord har skickats."
			redirect_to root_url
		else
			flash.now[:danger] = "E-postadressen kunde inte hittas."
			render 'new'
		end
	end

	def edit
		# Empty
	end

	def update
		if password_blank?
			flash.now[:danger] = "Lösenord måste anges!"
			render 'edit'
		elsif @user.update_attributes(user_params)
			log_in @user
			flash[:success] = "Lösenordet har uppdaterats."
			redirect_to @user
		else
			render 'edit'
		end
	end

	private

		def user_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		# Returns true if password is blank.
		def password_blank?
			params[:user][:password].blank?
		end

		def get_user
			@user = User.find_by(email: params[:email])
		end

		# Verify that user is valid using generalized authenticated? method.
		def valid_user
			unless (@user && @user.authenticated?(:reset, params[:id]))
				redirect_to root_url
			end
		end

		def check_expiration
			# Uses boolean test for password reset expiration from User model.
			if @user.password_reset_expired?
				flash[:danger] = "Lösenordet har gått ut."
				redirect_to new_password_reset_url
			end
		end
end

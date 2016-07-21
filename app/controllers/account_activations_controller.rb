class AccountActivationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activated, params[:id])
			user.activate
			log_in user
			flash[:success] = "Account Activated"
			redirect_to user
		else
			flash[:danger] = "Invalid activation link"
			redirect_to root_url
	end
 end
end

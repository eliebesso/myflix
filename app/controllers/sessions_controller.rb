class SessionsController < ApplicationController
	def new
		redirect_to root_path if logged_in?
	end

	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			login_user!(user)
		else
			flash[:error] = "There's something wrong with your username or password."
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've logged out!"
		redirect_to root_path
	end

	private
		def login_user!(user)
			session[:user_id] = user.id
			flash[:notice] = "You've logged in!"
			redirect_to root_path
		end
end
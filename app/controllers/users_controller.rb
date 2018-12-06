class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit]
	before_action :require_same_user, only: [:edit]
	before_filter :require_user, only: [:show]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			AppMailer.send_welcome_email(@user).deliver
			session[:user_id] = @user.id
			redirect_to login_path
		else
			render :new
		end
	end

	def show
	end

	private

	def user_params
		params.require(:user).permit(:full_name, :password, :email)
	end

	def set_user
		@user = User.find_by(id: params[:id])
	end

	def require_same_user
		if current_user != @user
			flash[:error] = "You're not allowed to do that"
			redirect_to root_path
		end
	end
end
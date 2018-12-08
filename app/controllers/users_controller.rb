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
			handle_invitation
			AppMailer.send_welcome_email(@user).deliver
			session[:user_id] = @user.id
			redirect_to login_path
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def new_with_invitation_token
		invitation = Invitation.where(token: params[:token]).first
		if invitation
			@user = User.new(email: invitation.recipient_email)
			@invitation_token = invitation.token
			render :new
		else
			redirect_to expired_token_path
		end
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

	def handle_invitation
		if params[:invitation_token].present?
			invitation = Invitation.where(token: params[:invitation_token]).first
			@user.follow(invitation.inviter)
			invitation.inviter.follow(@user)
			invitation.update_column(:token, nil )
		end
	end
end
require 'spec_helper'

describe ForgotPasswordsController do
	describe "POST create" do
		context "with blank input" do
			it "redirects to the forgot password page" do
				post :create, email: ''
				expect(response).to redirect_to forgot_password_path
			end
			
			it "shows errors message" do
				post :create, email: ''
				expect(flash[:error]).to eq("Email cannot be blank.")
			end
		end
		
		context "with existing email" do
			it "redirect to the forgot password confirmation page" do
				Fabricate(:user, email: "josias@example.com")
				post :create, email: "josias@example.com"
				expect(response).to redirect_to forgot_password_confirmation_path
			end
			it "sends out an email to the email address" do
				Fabricate(:user, email: "josias@example.com")
				post :create, email: "josias@example.com"
				expect(ActionMailer::Base.deliveries.last.to).to eq(['josias@example.com'])
			end
		end
		
		context "with non-existing email" do
			it "redirects to the forgot password page" do
				post :create, email: 'josias@example.com'
				expect(response).to redirect_to forgot_password_path
			end

			it "shows an error message" do
				post :create, email: 'josias@example.com'
				expect(flash[:error]).to eq("There is no user with that email in the system.")
			end
		end
	end
end








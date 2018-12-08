require 'spec_helper'

describe UsersController do
	describe "GET new" do
		it "sets @user" do
			get :new
			expect(assigns(:user)).to be_instance_of(User)
		end
	end

	describe "POST create" do
		context "with valid input" do

			before do
				post :create, user: Fabricate.attributes_for(:user)
			end

			it "creates the user" do				
				expect(User.count).to eq(1)
			end

			it "redirects to the sign in page" do
				expect(response).to redirect_to login_path
			end

			it "makes the user follow the inviter" do
				 josias = Fabricate(:user)
				 invitation = Fabricate(:invitation, inviter: josias, recipient_email: 'jurema@example.com')
				 post :create, user: { email: 'jurema@example.com', password: 'password', full_name: 'Jurema Bezerra' }, invitation_token: invitation.token
				 jurema = User.where(email: 'jurema@example.com').first
				 expect(jurema.follows?(josias)).to be_true
			end

			it "makes the inviter follow the user" do
				 josias = Fabricate(:user)
				 invitation = Fabricate(:invitation, inviter: josias, recipient_email: 'jurema@example.com')
				 post :create, user: { email: 'jurema@example.com', password: 'password', full_name: 'Jurema Bezerra' }, invitation_token: invitation.token
				 jurema = User.where(email: 'jurema@example.com').first
				 expect(josias.follows?(jurema)).to be_true
			end

			it "expires the invitation upon acceptance" do
				 josias = Fabricate(:user)
				 invitation = Fabricate(:invitation, inviter: josias, recipient_email: 'jurema@example.com')
				 post :create, user: { email: 'jurema@example.com', password: 'password', full_name: 'Jurema Bezerra' }, invitation_token: invitation.token
				 jurema = User.where(email: 'jurema@example.com').first
				 expect(Invitation.first.token).to be_nil
			end
		end

		context "with invalid input" do

			before do
				post :create, user: { email: "josias@example.com" }
			end
			
			it "does not create the user" do
				expect(User.count).to eq(0)
			end

			it "render the :new template" do
				expect(response).to render_template :new
			end

			it "sets @user" do
				expect(assigns(:user)).to be_instance_of(User)
			end
		end

		context "sending emails" do
			after { ActionMailer::Base.deliveries.clear }

			it "sends out email to the user with valid inputs" do
				post :create, user: { email: "josias@example.com", password: "password", full_name: "Josias Silva" }
				expect(ActionMailer::Base.deliveries.last.to).to eq(['josias@example.com']) 
			end

			it "sends out email containing the user's name with valid inputs" do
				post :create, user: { email: "josias@example.com", password: "password", full_name: "Josias Silva" }
				expect(ActionMailer::Base.deliveries.last.body).to include('Josias Silva') 
			end
			
			it "does not send out email with invalid inputs" do
				post :create, user: { email: "josias@example.com" }
				expect(ActionMailer::Base.deliveries).to be_empty
			end
		end
	end

	describe "GET show" do
		it_behaves_like "requires sign in" do
			let(:action) { get :show, id: 3 }
		end

		it "sets @user" do
			set_current_user
			josias = Fabricate(:user)
			get :show, id: josias.id
			expect(assigns(:user)).to eq(josias)
		end
	end

	describe 'GET new_with_invitation_token' do
		it "renders the :new view template" do
			invitation = Fabricate(:invitation)
			get :new_with_invitation_token, token: invitation.token
			expect(response).to render_template :new
		end

		it "sets @user with recipient's email" do
			invitation = Fabricate(:invitation)
			get :new_with_invitation_token, token: invitation.token
			expect(assigns(:user).email).to eq(invitation.recipient_email)
		end
 
		it "sets @invitation_token" do
			invitation = Fabricate(:invitation)
			get :new_with_invitation_token, token: invitation.token
			expect(assigns(:invitation_token)).to eq(invitation.token)
		end

		it "redirects to expired token page for invalid tokens" do
			get :new_with_invitation_token, token: 'safafaf'
			expect(response).to redirect_to expired_token_path
		end
	end

end










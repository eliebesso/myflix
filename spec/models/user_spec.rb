require 'spec_helper'

describe User do
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:password) }
	it { should validate_presence_of(:full_name) }
	it { should validate_presence_of(:email) }
	it { should have_many(:queue_items).order(:position) }
	it { should have_many(:reviews).order("created_at DESC") }

	it "generates a random token when the user is created" do
		josias = Fabricate(:user)
		expect(josias.token).to be_present
	end

	describe "#queued_video?" do
		it "returns true when the user queued the video" do
			user = Fabricate(:user)
			video = Fabricate(:video)
			Fabricate(:queue_item, user: user, video: video)
			user.queued_video?(video).should be_truthy
		end

		it "returns false when the user hasn't queued the video" do
			user = Fabricate(:user)
			video = Fabricate(:video)
			user.queued_video?(video).should be_falsey			
		end
	end

	describe "#follows?" do
		it "returns true if the user has a following relationship with another user" do
			josias = Fabricate(:user)
			bob = Fabricate(:user)
			Fabricate(:relationship, leader: bob, follower: josias)
			expect(josias.follows?(bob)).to be_truthy
		end
		
		it "returns false if the user does not have a following relationship with another user" do
			josias = Fabricate(:user)
			bob = Fabricate(:user)
			Fabricate(:relationship, leader: josias, follower: bob)
			expect(josias.follows?(bob)).to be_falsey
		end
	end
end






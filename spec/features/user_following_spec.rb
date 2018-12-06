require 'spec_helper'

feature 'User following' do
	scenario "user follows and unfollows someone" do

		josias = Fabricate(:user)
		category = Fabricate(:category)
		video = Fabricate(:video, category: category)
		Fabricate(:review, user: josias, video: video)

		login
		click_on_video_on_home_page(video)

		click_link josias.full_name
		click_link "Follow"
		expect(page).to have_content(josias.full_name)

		unfollow(josias)
		expect(page).not_to have_content(josias.full_name)
	end

	def unfollow(user)
		find("a[data-method='delete']").click
	end

end
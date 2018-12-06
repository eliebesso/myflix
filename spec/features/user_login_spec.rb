require 'spec_helper'

feature "user logins" do
	scenario "with valid email and password" do
		josias = Fabricate(:user)
		login(josias)
		page.should have_content josias.full_name
	end
end
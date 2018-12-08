require 'spec_helper'

feature 'User resets password' do	
	scenario "user successfully resets the password" do
		josias = Fabricate(:user, password: 'old_password')
		visit login_path
		click_link 'Forgot Password?'
		fill_in 'Email Address', with: josias.email
		click_button 'Send Email'

		open_email(josias.email)
		current_email.click_link("Reset My Password")

		fill_in 'New Password', with: 'new_password'
		click_button 'Reset Password'

		fill_in 'Email', with: josias.email
		fill_in 'Password', with: 'new_password'
		click_button 'Sign in'
		expect(page).to have_content("Welcome, #{josias.full_name}")

		clear_email
	end
end
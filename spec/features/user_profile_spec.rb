require 'rails_helper'
require 'spec_helper'

feature "Profile page" do
	let!(:user) { FactoryGirl.create(:user) }

	before do
		sign_in_as!(user)
		visit user_path(user)
	end					

	scenario "Viewing a user" do
		expect(page).to have_content(user.name)
		expect(page).to have_content(user.email)
	end

	scenario "Updating a user" do
		click_link "Edit Profile"
		fill_in "Username", with: "new_username"
		click_button "Update Profile"
		expect(page).to have_content("Profile has been updated.")
	end	
end
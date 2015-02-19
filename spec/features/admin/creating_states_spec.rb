require 'rails_helper'

feature "Creating states" do
	let!(:admin) { FactoryGirl.create(:admin_user)}

	before do
		sign_in_as!(admin)
	end
	
	scenario "Creating a state" do
		click_link "Admin"
		click_link "States"
		click_link "New State"
		fill_in "Name", with: "Duplicate"
		click_button "Create State"
		expect(page).to have_content("State has been created.")
	end
end			
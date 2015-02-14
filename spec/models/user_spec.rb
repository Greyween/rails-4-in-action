require 'rails_helper'
require 'spec_helper'

describe User do
  describe "passwords" do

  	it "needs a password and confirmation to save" do
  		user = User.new(name: "Steve", email: "steve@example.com")
  		user.save
  		expect(user).to_not be_valid
  		user.password = "password"
  		user.password_confirmation = ""
  		user.save
  		expect(user).to_not be_valid
  		user.password_confirmation = "password"
  		user.save
  		expect(user).to be_valid
  	end
  	
  	it "needs password and confirmation to match" do
  		user = User.create(name: "Steve", 
								  			password: "hunter2", 
								  			password_confirmation: "hunter")
  		expect(user).to_not be_valid
  	end
  end

  describe "authentication" do
  	let(:user) { User.create(name: "Steve", 
											  		password: "hunter2", 
											  		password_confirmation: "hunter2") }

		it "authenticates with a correct password" do
			expect(user.authenticate("hunter2")).to be
		end
		
		it "does not authenticate with an incorrect password" do
			expect(user.authenticate("hunter")).to_not be
		end
	end

	it "requires an email" do
		user = User.new(name: "Steve", password: "hunter2", password_confirmation: "hunter2")
		user.save
		expect(user).to_not be_valid
		user.email = "steve@example.com"
		user.save
		expect(user).to be_valid
	end													  					
end

FactoryGirl.define do
	sequence(:name) { |n| "username#{n}" }
	sequence(:email) {|n| "user#{n}@example.com" }

	factory :user do
		name { generate(:name) }
		email { generate(:email) }
		password "password"
		password_confirmation 'password'

		factory :admin_user do
			admin true
		end		
	end	
end		
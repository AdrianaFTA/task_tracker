FactoryBot.define do
  factory :user do
    # Devise requires a unique email. We use rand(1000) to ensure uniqueness in tests.
    sequence(:email) { |n| "testuser#{n}@example.com" } 
    
    # Devise requires a password
    password              { "password" }
    password_confirmation { "password" }
    
    # You can add other attributes here if your User model has them
    # name { "Test Name" }
  end
end
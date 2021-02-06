FactoryBot.define do
  
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    first_name { "Abdulazeez" }
    last_name { "Banjoko" }
    password { "asdfasdf" }
    password_confirmation { "asdfasdf" }
  end

  factory :admin_user, class: "AdminUser" do
    email { generate :email }
    first_name { "Sabith" }
    last_name { "Raji-Banjoko" }
    password { "asdfasdf" }
    password_confirmation { "asdfasdf" }
  end

  factory :non_authorized_user, class: "User" do
    email { generate :email }
    first_name { "Non" }
    last_name { "Authorized" }
    password { "asdfasdf" }
    password_confirmation { "asdfasdf" }
  end
end
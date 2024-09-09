FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password123' }
    name { '田中メアリー' }
    phone_number { '09012345678' }
  end
end

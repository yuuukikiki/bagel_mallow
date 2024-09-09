FactoryBot.define do
  factory :item do
    name { '抹茶ベーグル' }
    price { 1000 }
    description { 'これは抹茶のベーグルです' }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png') unless item.image.attached?
    end
  end
end

FactoryBot.define do
  factory :item do
    name { '抹茶ベーグル' }
    price { 1000 }
    description { 'これは抹茶のベーグルです' }
    image_url { 'public/images/test_image.png' }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

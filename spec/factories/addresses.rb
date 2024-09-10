FactoryBot.define do
  factory :address do
    postal_code { '123-4567' }
    city { '福岡市' }
    street { '1-22-33' }
    building_name { 'ビル名' }
    prefecture_id { 2 }

    association :user # userとの関連付け
  end
end
